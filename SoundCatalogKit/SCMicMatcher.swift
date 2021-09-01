//
//  SCMicMatcher.swift
//  SCMicMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

typealias AudioStreamUpdate = ((AVAudioPCMBuffer, AVAudioTime?) -> Void)
class SCMicMatcher: SCMatcher {
    private var audioEngine: AVAudioEngine!
    
    var isMatching: Bool {
        audioEngine.isRunning
    }
    var didUpdateAudioStream: AudioStreamUpdate = {_,_ in}
    var matchingFailed: ((Error) -> Void)?
    
    func beginMatching() {
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: .zero).sampleRate
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        audioEngine.inputNode.installTap(
            onBus: .zero,
            bufferSize: Constants.bufferSize,
            format: audioFormat
        ) { [weak self] buffer, audioTime in
            (self?.didUpdateAudioStream)!(buffer, audioTime)
        }
        
        do {
            try audioEngine.start()
        } catch {
            matchingFailed?(SCError(
                code: .SCErrorCodeAudioEngineFailed,
                description: "Audio engine failed to start. Error: \(error.localizedDescription)"
                )
            )
        }
    }
    
    func endMatching() {
        audioEngine.stop()
    }
}

extension SCMicMatcher {
    private enum Constants {
        static let bufferSize: UInt32 = 2048
    }
}
