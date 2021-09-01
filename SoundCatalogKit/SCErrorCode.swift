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
    case SCErrorCodeInvalidAudioFormat = 100
    /// The audio provided was not contiguous
    /// SoundCatalog requires audio to be contiguous in order
    /// to match.
    case SCErrorCodeAudioDiscontinuity = 101
    
    /// Failed to create a signature from the provided audio
    /// Validate the audio you are supplying, it may be silent.
    case SCErrorCodeSignatureInvalid = 200
    
    /// The signature duration is outside the valid range
    /// The signature is valid but is too long/short for
    /// the service attempting to match it
    case SCErrorCodeSignatureDurationInvalid = 201
    
    /// The request to match the signature failed
    /// The attempt failed and was not matched, trying again may result in 
    /// This code does not indicate a 'No Match'
    case SCErrorCodeMatchAttemptFailed = 202
    
    /// Failed to load the Custom Catalog
    /// Validate the structure of the Catalog file
    case SCErrorCodeCustomCatalogInvalid = 300
    
    /// The Custom Catalog URL was invalid
    /// The URL must be a filePath URL that contains a valid Catalog
    case SCErrorCodeCustomCatalogInvalidURL = 301
    
    case SCErrorCodeAudioEngineFailed = 401
    
    case customCatalogSaveAttemptFailed = 402
    
    case maximumCatalogItemsExceeded = 403
    
    case invalidAudioFile = 404
    
}
