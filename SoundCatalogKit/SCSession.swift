//
//  SCSession.swift
//  SoundCatalogKit
//
//  Created by David Ilenwabor on 31/08/2021.
//

import AVFAudio
import ShazamKit

protocol SCSessionProtocol {
    func startMatching()
    func stopMatching()
}

@objc public protocol SCSessionDelegate: AnyObject {
    @objc optional func session(_ session: SCSession, didFind match: SCMatch)
    @objc optional func session(_ session: SCSession, 
                                didNotFindMatchFor signature: SCSignature, 
                                error: Error?)
    @objc optional func session(_ session: SCSession, failedToMatchDueTo error: Error)
    @objc optional func sessionDidStartMatch(_ session: SCSession)
    @objc optional func sessionDidStopMatch(_ session: SCSession)
} 

public class SCSession: NSObject, SCSessionProtocol {
    private var session: SHSession!
    private var matcher: SCStreamer!
    private var sessionResultSource: SCSessionResultSource!
    public var isMatching: Bool {
        matcher.isStreaming
    }
    public weak var delegate: SCSessionDelegate?
    
    private override init() {
        super.init()
    }
    
    public convenience init(catalog: SCCustomCatalog) {
        self.init()
        session = SHSession(catalog: catalog.customCatalog)
        sessionResultSource = SCSessionResultSource()
        matcher = SCMicStreamer()
        setupMatcher()
        sessionResultSource.delegate = self
        session.delegate = sessionResultSource
    }
    
    public func startMatching() {
        delegate?.sessionDidStartMatch?(self)
        matcher.beginStreaming()
    }
    
    public func stopMatching() {
        matcher.endStreaming()
        delegate?.sessionDidStopMatch?(self)
    }
    
    private func setupMatcher() {
        matcher.didUpdateAudioStream = {  [weak session] buffer, audioTime in
            guard let session = session else { return }
            session.matchStreamingBuffer(buffer, at: audioTime)
        }
        matcher.streamingFailed = { [weak self] error in
            guard let self = self else { return }
            self.delegate?.session?(
                self,
                failedToMatchDueTo: error
            )
        }
    }
}

extension SCSession: SCSessionResultDelegate {
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        delegate?.session?(self, didNotFindMatchFor: SCSignature(signature: signature), error: error)
    }

    func session(_ session: SHSession, didFind match: SHMatch) {
        delegate?.session?(self, didFind: SCMatch(match: match))
    }
}
