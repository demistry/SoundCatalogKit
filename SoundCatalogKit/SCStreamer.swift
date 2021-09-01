//
//  SCMatcher.swift
//  SCMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

protocol SCStreamer {
    var isStreaming: Bool { get }
    var didUpdateAudioStream: (AVAudioPCMBuffer, AVAudioTime?) throws -> Void { get set }
    var streamingFailed: ((Error) throws -> Void)? { get set }
    
    func beginStreaming()
    func endStreaming()
}
