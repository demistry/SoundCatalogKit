//
//  SCSignature.swift
//  SCSignature
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCSignature: NSObject {
    private(set) var signature: SHSignature
    
    init(signature: SHSignature) {
        self.signature = signature
    }
    
    public init(dataRepresentation data: Data) throws {
        do {
            self.signature = try SHSignature(dataRepresentation: data)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureInvalid)
        }
    }
}
