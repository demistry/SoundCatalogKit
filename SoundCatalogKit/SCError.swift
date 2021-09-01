//
//  SCError.swift
//  SCError
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

class SCError: NSError {
    private let bundleId = Bundle.main.bundleIdentifier ?? "shazam"

    init(code: SCErrorCode, description: String) {
        super.init(domain: bundleId, code: code.rawValue, userInfo: [NSDebugDescriptionErrorKey: description])
    }
    
    init(code: SCErrorCode, userInfo: [String: Any]) {
        super.init(domain: bundleId, code: code.rawValue, userInfo: userInfo)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
