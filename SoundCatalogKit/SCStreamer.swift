//
//  SCMatcher.swift
//  SCMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

protocol StreamerDelegate: AnyObject {
    func streamer(
        _ streamer: SCStreamer,
        didUpdateAudioStream buffer: AVAudioPCMBuffer,
        withTime time: AVAudioTime?
    )
    func streamer(_ streamer: SCStreamer, didFail error: Error)
}

protocol SCStreamer {
    var isStreaming: Bool { get }
    var didUpdateAudioStream: (AVAudioPCMBuffer, AVAudioTime?) throws -> Void { get set }
    var streamingFailed: ((Error) throws -> Void)? { get set }
    var delegate: StreamerDelegate? { get set }
    
    func beginStreaming()
    func endStreaming()
}
