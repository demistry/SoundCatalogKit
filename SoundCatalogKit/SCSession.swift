//
//  SCSession.swift
//  SoundCatalogKit
//
//  Created by David Ilenwabor on 31/08/2021.
//

import AVFAudio
import ShazamKit
struct Er: Error {
    
}
protocol SCSessionProtocol {
    func startMatching()
    func stopMatching()
}

public protocol SCSessionDelegate: AnyObject {
    func session(_ session: SCSession, didFind match: SCMatch)
    func session(_ session: SCSession, didNotFindMatchFor signature: SCSignature, error: Error?)
    func session(_ session: SCSession, failedToMatchDueTo error: Error)
}

extension SCSessionDelegate {
    func session(_ session: SCSession, didFind match: SCMatch) {}
    func session(_ session: SCSession, didNotFindMatchFor signature: SCSignature, error: Error?) {}
    func session(_ session: SCSession, failedToMatchDueTo error: Error) {}
}

public class SCSession: NSObject, SCSessionProtocol {
    private var session: SHSession!
    private var audioEngine: AVAudioEngine!
    private var sessionResultSource: SCSessionResultSource!
    public var isMatching: Bool {
        audioEngine.isRunning
    }
    public weak var delegate: SCSessionDelegate?
    
    private override init() {
        super.init()
    }
    
    public convenience init(catalog: SCCatalog) {
        self.init()
        session = SHSession(catalog: catalog.customCatalog)
        sessionResultSource = SCSessionResultSource()
        audioEngine = AVAudioEngine()
        sessionResultSource.delegate = self
        session.delegate = sessionResultSource
    }
    
    public func startMatching() {
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: .zero).sampleRate
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        audioEngine.inputNode.installTap(
            onBus: .zero,
            bufferSize: Constants.bufferSize,
            format: audioFormat
        ) { [weak session] buffer, audioTime in
            session?.matchStreamingBuffer(buffer, at: audioTime)
        }
        
        do {
            try audioEngine.start()
        } catch {
            delegate?.session(
                self,
                failedToMatchDueTo: SCError(
                    code: .SCErrorCodeAudioEngineFailed,
                    description: "Audio engine failed to start. Error: \(error.localizedDescription)"
                )
            )
        }
    }
    
    public func stopMatching() {
        audioEngine.stop()
    }
}

extension SCSession: SCSessionResultDelegate {
    private enum Constants {
        static let bufferSize: UInt32 = 2048
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        delegate?.session(self, didNotFindMatchFor: SCSignature(signature: signature), error: error)
    }

    func session(_ session: SHSession, didFind match: SHMatch) {
        delegate?.session(self, didFind: SCMatch(match: match))
//        SHError.
    }
}
