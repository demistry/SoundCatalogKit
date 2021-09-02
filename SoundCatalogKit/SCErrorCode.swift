//
//  SCErrorCode.swift
//  SCErrorCode
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

public enum SCErrorCode: Int {
    /// The @c AVAudioFormat is not supported
    /// SoundCatalogKit only accepts certain audio formats
    /// -[SHSignatureGenerator appendBuffer:atTime:error] for valid formats
    case invalidAudioFormat = 100
    /// The audio provided was not contiguous
    /// SoundCatalog requires audio to be contiguous in order
    /// to match.
    case audioDiscontinuity = 101
    
    /// Failed to create a signature from the provided audio
    /// Validate the audio you are supplying, it may be silent.
    case signatureInvalid = 200
    
    /// The signature duration is outside the valid range
    /// The signature is valid but is too long/short for
    /// the service attempting to match it
    case signatureDurationInvalid = 201
    
    /// The request to match the signature failed
    /// The attempt failed and was not matched, trying again may result in 
    /// This code does not indicate a 'No Match'
    case matchAttemptFailed = 202
    
    /// Failed to load the Custom Catalog
    /// Validate the structure of the Catalog file
    case customCatalogInvalid = 300
    
    /// The Custom Catalog URL was invalid
    /// The URL must be a filePath URL that contains a valid Catalog
    case customCatalogInvalidURL = 301
    
    case audioEngineFailed = 401
    
    case customCatalogSaveAttemptFailed = 402
    
    case maximumCatalogItemsExceeded = 403
    
    case invalidAudioFile = 404
    
    case invalidSignaturePath = 405
    
}
