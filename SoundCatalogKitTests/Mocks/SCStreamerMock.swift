//
//  SCStreamerMock.swift
//  SCStreamerMock
//
//  Created by David Ilenwabor on 02/09/2021.
//
import AVFAudio
import Foundation
@testable import SoundCatalogKit

class SCStreamerMock: SCStreamer {
    var isStreaming: Bool = false
    
    var didUpdateAudioStream: (AVAudioPCMBuffer, AVAudioTime?) -> Void = {_,_ in}
    
    var streamingFailed: ((Error) -> Void)?
    
    var delegate: StreamerDelegate?
    
    func beginStreaming() {
        isStreaming = true
    }
    
    func endStreaming() {
        isStreaming = false
    }
    
    
}
