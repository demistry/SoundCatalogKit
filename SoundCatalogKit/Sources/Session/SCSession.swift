//
//  SCSession.swift
//  SoundCatalogKit
//
//  Created by David Ilenwabor on 31/08/2021.
//

import AVFAudio
import ShazamKit

/// All communication about matches is performed through this delegate.
@objc public protocol SCSessionDelegate: NSObjectProtocol {
    
    /// Tells the delegate that the query signature matches an item in the catalog.
    /// 
    /// - Parameters:
    ///     - session: The session object that made the match
    ///     - match: The matching items from the catalog.
    @objc optional func session(_ session: SCSession, didFind match: SCMatch)
    
    /// Tells the delegate the query signature does not match an item in the catalog or there is an error
    /// 
    /// You can retry the match if the error indicates an issue in communicating with the catalog server, such as `SCErrorCode.matchAttemptfailed`.
    /// 
    /// - Parameters:
    ///     - session: The session object that made the match
    ///     - signature: The query signature used for the match
    ///     - error: The error that occurs; otherwise, nil, which indicates that there’s no match.
    @objc optional func session(_ session: SCSession, 
                                didNotFindMatchFor signature: SCSignature, 
                                error: Error?)
    
    /// Matching against microphone was unable to start due to an error
    /// 
    /// You should obtain microphone permissions if the error returned is `SCErrorCode.audioEngineFailed`
    /// 
    /// - Parameters:
    ///     - session: The session object that attempted the match
    ///     - error: The error returned for why the match failed
    @objc optional func session(_ session: SCSession, failedToMatchDueTo error: Error)
    
    /// Matching against microphone started successfully
    /// 
    /// - Parameters:
    ///     - session: The session object that started the match
    @objc optional func sessionDidStartMatch(_ session: SCSession)
    
    /// Matching against microphone stopped
    /// 
    /// - Parameters:
    ///     - session: The session object that stopped the match
    @objc optional func sessionDidStopMatch(_ session: SCSession)
} 

/// An object that manages matching a specific audio recording when a segment of that recording is part of captured sound from an input audio stream such as a microphone.
/// 
/// Prepare to make matches by: 
/// - Creating a session for the catalog that contains the reference signatures
/// - Adding your delegate that receives the match results
/// 
/// Search for a match by calling `startMatching()` .
/// 
/// Call `stopMatching()` to stop the input audio stream.
/// 
/// Searching the custom catalog is asynchronous. The session calls your delegate methods with the result.
/// 
/// > Important: **Ensure microphone permissions are duly requested and granted by the user before attempting a match.**
public class SCSession: NSObject {
    private var session: SHSession
    private var streamer: SCStreamer!
    private var sessionResultSource: SCSessionResultSource!
    
    /// A flag to check if the session is currently matching input audio stream
    public var isMatching: Bool {
        streamer.isStreaming
    }
    
    /// The object that the session calls with the result of a match request.
    public weak var delegate: SCSessionDelegate?
    
    private override init() {
        session = SHSession()
        super.init()
    }
    
    convenience init(streamer: SCStreamer) {
        self.init()
        self.streamer = streamer
    }
    
    /// Creates a new session for matching audio in a custom catalog.
    /// 
    /// - Parameters:
    ///     - catalog: The custom catalog to match against using this session
    public init(catalog: SCCatalog) {
        session = SHSession(catalog: catalog.getCustomCatalog().customShazamCatalog)
        super.init()
        sessionResultSource = SCSessionResultSource()
        streamer = SCMicStreamer()
        setupMatcher()
        sessionResultSource.delegate = self
        session.delegate = sessionResultSource
    }
    
    /// Converts the continous input audio buffer to a signature, and searches the reference signatures in the session catalog.
    public func startMatching() {
        delegate?.sessionDidStartMatch?(self)
        streamer.beginStreaming()
    }
    
    /// Stops searching the reference signatures in the session catalog.
    public func stopMatching() {
        streamer.endStreaming()
        delegate?.sessionDidStopMatch?(self)
    }
    
    private func setupMatcher() {
        streamer.didUpdateAudioStream = {  [weak session] buffer, audioTime in
            guard let session = session else { return }
            session.matchStreamingBuffer(buffer, at: audioTime)
        }
        streamer.streamingFailed = { [weak self] error in
            guard let self = self else { return }
            self.delegate?.session?(
                self,
                failedToMatchDueTo: error
            )
        }
    }
}

// MARK: - SCSessionResultDelegate implementation
extension SCSession: SCSessionResultDelegate {
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        delegate?.session?(self, didNotFindMatchFor: SCSignature(signature: signature), error: error)
    }

    func session(_ session: SHSession, didFind match: SHMatch) {
        delegate?.session?(self, didFind: SCMatch(match: match))
    }
}
