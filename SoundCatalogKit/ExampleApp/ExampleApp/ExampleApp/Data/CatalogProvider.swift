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
            return try await addCatalogFromRemote()
        case .DownloadSignatureFromURL, .AddReferenceSignatureFromRemote:
            return try await addSignatureFromRemoteURL()
        case .AddReferenceSignatureToCatalog:
            return try addSignatureFromLocalSource()
        case .AddCatalogFromLocalSource:
            return try addCatalogFromLocalSource()
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
    
    private static func addCatalogFromRemote() async throws -> SCCatalog? {
        let directDownloadLink = URL(string: "https://drive.google.com/uc?id=1G5FEwmHJGU9c9Gnbt0gGTDlSjSvhbmaU&export=download")!
        let customCatalog = SCCustomCatalog()
        do {
            try await customCatalog.addRemoteCatalog(fromRemoteURL: directDownloadLink)
        } catch {
            print("Error with downloading catalog file \(error)")
        }
        print("PLAYING FROM REMOTE CATALOG")
        return customCatalog
    }
    
    private static func addCatalogFromLocalSource() throws -> SCCatalog? {
        guard let signaturePath = Bundle.main.url(forResource: "BabyShark", withExtension: "shazamcatalog") else {
            return nil
        }
        print("Adding custom catalog from url \(signaturePath)")
        let customCatalog = SCCustomCatalog()
        try customCatalog.add(from: signaturePath)
        return customCatalog
    }
    
    private static func addSignatureFromRemoteURL() async throws -> SCCatalog? {
        let directDownloadLink = URL(string: "https://drive.google.com/uc?id=1ZMu7qH6q2UfA4kL17PXS64XJkTSptgl1&export=download")!
        let customCatalog = SCCustomCatalog()
        let signatureGenerator = SCSignatureGenerator()
        do {
            print("Downloading signature file...")
            let signature = try await signatureGenerator.downloadSignatureFromRemoteURL(directDownloadLink)
            try customCatalog.addReferenceSignature(signature, representing: [])
        } catch {
            print("Error with downloading signature file \(error)")
        }
        print("PLAYING FROM REMOTE SIGNATURE FILE")
        return customCatalog
    }
    
    private static func addSignatureFromLocalSource() throws -> SCCatalog? {
        guard let signaturePath = Bundle.main.url(forResource: "BabyShark", withExtension: "shazamsignature") else {
            return nil
        }
        print("Signature path \(signaturePath)")
        let signatureData = try Data(contentsOf: signaturePath)
        let signature = try SCSignature(dataRepresentation: signatureData)
        let customCatalog = SCCustomCatalog()
        try customCatalog.addReferenceSignature(signature, representing: [])
        
        return customCatalog
    }
}

