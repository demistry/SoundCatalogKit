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
    
    public func signature() -> SCSignature {
        return SCSignature(signature: signatureGenerator.signature())
    }
}
