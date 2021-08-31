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
    init(signature: SHSignature) {
        self.signature = signature
    }
}
