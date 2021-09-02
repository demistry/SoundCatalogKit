//
//  SCMicMatcher.swift
//  SCMicMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

typealias AudioStreamUpdate = ((AVAudioPCMBuffer, AVAudioTime?) throws -> Void)

/// Used to stream input audio from the microphone
class SCMicStreamer: SCStreamer {
    private var audioEngine: AVAudioEngine
    
    var isStreaming: Bool {
        audioEngine.isRunning
    }
    /// Delivers updates on an ongoing stream
    var didUpdateAudioStream: AudioStreamUpdate = {_, _ in}
    
    /// Delivers an error that occured on an ongoing stream
    var streamingFailed: ((Error) throws -> Void)?
    
    /// Delegate to send information on an ongoing stream
    weak var delegate: StreamerDelegate?
    
    init() {
        audioEngine = AVAudioEngine()
    }
    
    /// Begin streaming audio from microphone
    func beginStreaming() {
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: .zero).sampleRate
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        audioEngine.inputNode.installTap(
            onBus: .zero,
            bufferSize: Constants.bufferSize,
            format: audioFormat
        ) { [weak self] buffer, audioTime in
            guard let self = self else { return }
            self.delegate?.streamer(self, didUpdateAudioStream: buffer, withTime: audioTime)
            try? self.didUpdateAudioStream(buffer, audioTime)
        }
        
        do {
            try audioEngine.start()
        } catch {
            try? streamingFailed?(SCError(
                code: .audioEngineFailed,
                description: "Audio engine failed to start. Error: \(error.localizedDescription)"
                )
            )
            delegate?.streamer(self, didFail: SCError(
                code: .audioEngineFailed,
                description: "Audio engine failed to start. Error: \(error.localizedDescription)"
                )
            )
        }
    }
    
    /// Stop streaming from microphone
    func endStreaming() {
        audioEngine.stop()
    }
}

extension SCMicStreamer {
    private enum Constants {
        static let bufferSize: UInt32 = 2048
    }
}
