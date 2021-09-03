//
//  SCError.swift
//  SCError
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

/// An error type that you create, or the system creates, to indicate problems with a catalog, match attempt, or signature.
public class SCError: NSError {
    private let domainURL = "com.davidemi.SoundCatalogKit"

    /// Creates a SoundCatalogKit error of the specified type with the specified description.
    public init(code: SCErrorCode, description: String) {
        super.init(
            domain: domainURL,
            code: code.rawValue,
            userInfo: [NSDebugDescriptionErrorKey: description]
        )
    }
    
    /// Creates a SoundCatalogKit error of the specified type with the specified user information.
    public init(code: SCErrorCode, userInfo: [String: Any]) {
        super.init(domain: domainURL, code: code.rawValue, userInfo: userInfo)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SCError {
    convenience init(shError: Error, defaultErrorCode: SCErrorCode) {
        let error = shError as NSError
        self.init(
            code: SCErrorCode(rawValue: error.code) ?? defaultErrorCode,
            userInfo: error.userInfo
        )
    }
}
