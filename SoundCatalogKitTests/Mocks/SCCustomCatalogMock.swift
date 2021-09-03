//
//  SCCustomCatalogMock.swift
//  SCCustomCatalogMock
//
//  Created by David Ilenwabor on 02/09/2021.
//

import AVFAudio
import Foundation
import SoundCatalogKit

class SCCustomCatalogMock: SCCatalog {
    private var customCatalog: SCCustomCatalog!
    var isSuccessful: Bool =  true
    private var downloader: SCDownloaderMock
    init(downloader: SCDownloaderMock) {
        self.downloader = downloader
        customCatalog = SCCustomCatalog()
    }
    
    func addReferenceSignature(_ referenceSignature: SCSignature, representing mediaItems: [SCMediaItem]) throws {}
    
    func addReferenceSignatureData(_ referenceData: Data, representing mediaItems: [SCMediaItem]) throws {}
    
    func addSignatureFromAudioFile(withUrl audioURL: URL, andAudioFormat format: AVAudioFormat?, representing mediaItems: [SCMediaItem]) throws {}
    
    func addRemoteSignature(fromRemoteURL url: URL, representing mediaItems: [SCMediaItem]) async throws {
//        if isSuccessful {
//            let signatureURL = try! await downloader.downloadFileFromURL(url)
//            let signature = try! SCSignature(dataRepresentation: Data(contentsOf: signatureURL))
//            
//        } else {
//            throw SCError(code: .signatureInvalid, description: "Could not add signature from remote file")
//        }
    }
    
    func addRemoteCatalog(fromRemoteURL url: URL) async throws {
//        if isSuccessful {
//            addedRemoteCatalog?(url)
//        } else {
//            throw SCError(code: .customCatalogInvalid, description: "Could not add catalog from remote file")
//        }
    }
    
    func add(from url: URL) throws {}
    
    func write(to url: URL) throws {}
    
    func getCustomCatalog() -> SCCustomCatalog {
        return customCatalog
    }
    
    
}
