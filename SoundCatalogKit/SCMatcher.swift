//
//  SCMatcher.swift
//  SCMatcher
//
//  Created by David Ilenwabor on 01/09/2021.
//

import AVFAudio
import Foundation

protocol SCMatcher {
    var isMatching: Bool { get }
    var didUpdateAudioStream: (AVAudioPCMBuffer, AVAudioTime?) -> Void { get set }
    var matchingFailed: ((Error) -> Void)? { get set }
    
    func beginMatching()
    func endMatching()
}
