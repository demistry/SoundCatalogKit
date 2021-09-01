//
//  SCSignatureGenerator.swift
//  SCSignatureGenerator
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

class SCSignatureGenerator {
    private var signatureGenerator: SHSignatureGenerator
    private lazy var streamer: SCStreamer = {
        let streamer = SCMicStreamer()
        return streamer
    }()
    public init() {
        signatureGenerator = SHSignatureGenerator()
    }
    
    public func append(_ buffer: AVAudioPCMBuffer, at time: AVAudioTime?) throws {
        do {
            try signatureGenerator.append(buffer, at: time)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .SCErrorCodeInvalidAudioFormat)
        }
    }
    
    public func generateSignatureFromAudioStream() throws {
        if streamer.isStreaming {
            return
        }
        streamer.streamingFailed = { error in
            throw error
        }
        streamer.beginStreaming()
        repeat {
            streamer.didUpdateAudioStream = { [weak signatureGenerator] buffer, audioTime in
                do {
                    try signatureGenerator?.append(buffer, at: audioTime)
                } catch {
                    throw error
                }
            }
            
        } while streamer.isStreaming
    }
    
    public func stopGeneratingSignatureFromAudioStream() {
        if streamer.isStreaming {
            streamer.endStreaming()
        }
    }
    
    public func signature() -> SCSignature {
        return SCSignature(signature: signatureGenerator.signature())
    }
}
