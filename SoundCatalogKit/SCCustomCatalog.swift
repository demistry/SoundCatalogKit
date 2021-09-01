//
//  SCCustomCatalog.swift
//  SCCustomCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation

protocol SCCatalog {
    func addReferenceSignature(
        _ referenceSignature: SCSignature,
        representing mediaItems: [SCMediaItem]
    ) throws
    
    public func addReferenceSignatureData(
        _ referenceData: Data,
        representing mediaItems: [SCMediaItem]
    ) throws
}
