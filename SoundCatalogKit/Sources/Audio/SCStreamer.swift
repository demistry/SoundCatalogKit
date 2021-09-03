//
//  SCMatcher.swift
//  SCMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

/// Used to send information on audio stream
protocol StreamerDelegate: AnyObject {
    func streamer(
        _ streamer: SCStreamer,
        didUpdateAudioStream buffer: AVAudioPCMBuffer,
        withTime time: AVAudioTime?
    )
    func streamer(_ streamer: SCStreamer, didFail error: Error)
}

/// Base protocol that all streaming objects conform to
protocol SCStreamer {
    var isStreaming: Bool { get }
    var didUpdateAudioStream: (AVAudioPCMBuffer, AVAudioTime?) -> Void { get set }
    var streamingFailed: ((Error) -> Void)? { get set }
    var delegate: StreamerDelegate? { get set }
    
    func beginStreaming()
    func endStreaming()
}
