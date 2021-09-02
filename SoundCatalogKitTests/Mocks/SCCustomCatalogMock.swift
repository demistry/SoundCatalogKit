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
    var customCatalog: SCCustomCatalog!
    var addedReferenceSignature: ((SCSignature, [SCMediaItem]) -> Void)?
    var addedReferenceData: ((Data, [SCMediaItem]) -> Void)?
    var addedReferenceSignatureFromAudioFile: ((URL, [SCMediaItem]) -> Void)?
    var addedRemoteSignature: ((URL, [SCMediaItem]) -> Void)?
    var addedRemoteCatalog: ((URL) -> Void)?
    var addedCatalogFromURL: ((URL) -> Void)?
    var wroteCatalogToURL: ((URL) -> Void)?
    var isSuccessful: Bool =  true
    
    func addReferenceSignature(_ referenceSignature: SCSignature, representing mediaItems: [SCMediaItem]) throws {
        if isSuccessful {
            addedReferenceSignature?(referenceSignature, mediaItems)
        } else {
            throw SCError(code: .signatureInvalid, description: "Could not add reference signature")
        }
    }
    
    func addReferenceSignatureData(_ referenceData: Data, representing mediaItems: [SCMediaItem]) throws {
        if isSuccessful {
            addedReferenceData?(referenceData, mediaItems)
        } else {
            throw SCError(code: .signatureInvalid, description: "Could not add reference signature data")
        }
    }
    
    func addSignatureFromAudioFile(withUrl audioURL: URL, andAudioFormat format: AVAudioFormat?, representing mediaItems: [SCMediaItem]) throws {
        if isSuccessful {
            addedReferenceSignatureFromAudioFile?(audioURL, mediaItems)
        } else {
            throw SCError(code: .invalidAudioFile, description: "Could not add signature from audio file")
        }
    }
    
    func addRemoteSignature(fromRemoteURL url: URL, representing mediaItems: [SCMediaItem]) async throws {
        if isSuccessful {
            addedRemoteSignature?(url, mediaItems)
        } else {
            throw SCError(code: .signatureInvalid, description: "Could not add signature from remote file")
        }
    }
    
    func addRemoteCatalog(fromRemoteURL url: URL) async throws {
        if isSuccessful {
            addedRemoteCatalog?(url)
        } else {
            throw SCError(code: .customCatalogInvalid, description: "Could not add catalog from remote file")
        }
    }
    
    func add(from url: URL) throws {
        if isSuccessful {
            addedCatalogFromURL?(url)
        } else {
            throw SCError(code: .customCatalogInvalidURL, description: "Could not add catalog from local file")
        }
    }
    
    func write(to url: URL) throws {
        if isSuccessful {
            wroteCatalogToURL?(url)
        } else {
            throw SCError(code: .customCatalogSaveAttemptFailed, description: "Could not save catalog as local file")
        }
    }
    
    func getCustomCatalog() -> SCCustomCatalog {
        return customCatalog
    }
    
    
}
