//
//  SCErrorCode.swift
//  SCErrorCode
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

/// Codes for the errors that SoundCatalogKit produces.
public enum SCErrorCode: Int {
    
    /// The error code to indicate an unsupported audio format.
    case invalidAudioFormat = 100
    
    /// The error code to indicate the use of noncontiguous audio to request a match.
    case audioDiscontinuity = 101
    
    /// The error code to indicate that the audio input stream is unable to start.
    case audioEngineFailed = 103
    
    /// The error code to indicate when a file URL isn't a valid audio type.
    case invalidAudioFile = 104
    
    /// The error code to indicate that the system is unable to generate a signature from the audio.
    case signatureInvalid = 200
    
    /// The error code to indicate that the length of the generated signature is too long or too short to make a match in the catalog.
    case signatureDurationInvalid = 201
    
    /// The error code to indicate when the signature fails to save at a particular destination URL .
    case signatureSaveAttemptFailed = 205
    
    /// The error code to indicate when a Custom catalog issue prevents finding a match.
    case matchAttemptFailed = 202
    
    /// The error code to indicate that the format for the custom catalog URL is invalid.
    case customCatalogInvalid = 300
    
    /// The error code to indicate when the custom catalog fails to load due to an invalid format.
    case customCatalogInvalidURL = 301
    
    /// The error code to indicate when the custom catalog fails to save at a particular destination URL.
    case customCatalogSaveAttemptFailed = 302
}
