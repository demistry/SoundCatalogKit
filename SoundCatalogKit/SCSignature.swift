//
//  SCSignature.swift
//  SCSignature
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCSignature {
    private var signature: SHSignature
    public init(dataRepresentation data: Data) throws {
        do {
            self.signature = try SHSignature(dataRepresentation: data)
        } catch {
            let error = error as NSError
            throw SCError(
                code: SCErrorCode(rawValue: error.code) ?? .SCErrorCodeSignatureInvalid,
                userInfo: error.userInfo
            )
        }
    }
    
    init(signature: SHSignature) {
        self.signature = signature
    }
}
