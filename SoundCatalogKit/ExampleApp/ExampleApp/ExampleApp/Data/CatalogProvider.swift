//
//  CatalogProvider.swift
//  CatalogProvider
//
//  Created by David Ilenwabor on 03/09/2021.
//

import SoundCatalogKit

struct CatalogProvider {
    
    static func catalog(state: FrameworkActions) async throws -> SCCatalog? {
        switch state {
        case .AddReferenceSignatureFromAudioFile, .CreateSignatureFromAudioFile: 
            return try addSignatureFromAudioFile()
        case .AddCatalogFromRemote:
            return try addCatalogFromRemote()
        case .DownloadSignatureFromURL, .AddReferenceSignatureFromRemote:
            return try addSignatureFromRemoteURL()
        case .AddReferenceSignatureToCatalog:
            return try addSignatureFromLocalSource()
        case .AddCatalogFromLocalSource:
            return try addSignatureFromLocalSource()
        }
        
    }

    private static func addSignatureFromAudioFile() throws -> SCCatalog? {
        guard let audioPath = Bundle.main.url(forResource: "BabyShark", withExtension: "m4a") else {
            return nil
        }
        // custom catalog uses SCSignatureGenerator under the hood to generate signature from audio file
        let customCatalog = SCCustomCatalog()
        try customCatalog.addSignatureFromAudioFile(withUrl: audioPath, andAudioFormat: nil, representing: [])
        
        return customCatalog
    }
    
    private static func addCatalogFromRemote() throws -> SCCatalog? {
        return nil
    }
    
    private static func addCatalogFromLocalSource() throws -> SCCatalog? {
        return nil
    }
    
    private static func addSignatureFromRemoteURL() throws -> SCCatalog? {
        return nil
    }
    
    private static func addSignatureFromLocalSource() throws -> SCCatalog? {
        return nil
    }
}

