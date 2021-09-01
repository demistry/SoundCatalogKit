//
//  SHCatalog.swift
//  SHCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCCatalog {
    private(set) var customCatalog: SHCustomCatalog
    
    public init() {
        customCatalog = SHCustomCatalog()
    }  
    
    public func addReferenceSignature(
        _ referenceSignature: SCSignature,
        representing mediaItems: [SCMediaItem]
    ) throws {
        do {
            try customCatalog.addReferenceSignature(
                referenceSignature.signature,
                representing: mediaItems.map({ $0.mediaItem }))
        } catch {
            let error = error as NSError
            throw SCError(
                code: SCErrorCode(rawValue: error.code) ?? .SCErrorCodeSignatureInvalid,
                userInfo: error.userInfo)
        }
    }
    
    // Add for url
    // Add for writing to url
    // add for downloading catalog from url and take in optional media items
    // add for creating catalog
}
