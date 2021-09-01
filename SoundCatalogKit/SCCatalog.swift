//
//  SCCustomCatalog.swift
//  SCCustomCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public protocol SCCatalog { 
    func addReferenceSignature(
        _ referenceSignature: SCSignature,
        representing mediaItems: [SCMediaItem]
    ) throws
    
    func addReferenceSignatureData(
        _ referenceData: Data,
        representing mediaItems: [SCMediaItem]
    ) throws
    
    func add(from url: URL) throws
    
    func write(to url: URL) throws
}
