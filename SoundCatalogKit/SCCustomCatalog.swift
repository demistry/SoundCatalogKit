//
//  SHCatalog.swift
//  SHCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCCustomCatalog: SCCatalog {
    private(set) var customShazamCatalog: SHCustomCatalog
    private var downloader: SCDownloader {
        return SCDownloadManager()
    }
    public init() {
        customShazamCatalog = SHCustomCatalog()
    }
    
    public func addReferenceSignature(
        _ referenceSignature: SCSignature,
        representing mediaItems: [SCMediaItem]
    ) throws {
        do {
            try customShazamCatalog.addReferenceSignature(
                referenceSignature.signature,
                representing: mediaItems.map({ $0.mediaItem }))
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureInvalid)
        }
    }

    public func addReferenceSignatureData(
        _ referenceData: Data,
        representing mediaItems: [SCMediaItem]
    ) throws {
        do {
            let signature = try SHSignature(dataRepresentation: referenceData)
            try customShazamCatalog.addReferenceSignature(
                signature,
                representing: mediaItems.map({ $0.mediaItem }))
        } catch {
            throw SCError(shError: error, defaultErrorCode: .signatureInvalid)
        }
    }
    
    public func addSignatureFromAudioFile(
        withUrl audioURL: URL,
        andAudioFormat format: AVAudioFormat?,
        representing mediaItems: [SCMediaItem]
    ) throws {
        let signatureGenerator = SCSignatureGenerator()
        do {
            try signatureGenerator.generateSignatureFromAudioFile(withUrl: audioURL, andAudioFormat: format)
            try addReferenceSignature(
                signatureGenerator.signature(),
                representing: mediaItems
            )
        } catch {
            throw error
        }
    }
    
    public func addRemoteSignature(
        fromRemoteURL url: URL,
        representing mediaItems: [SCMediaItem]
    ) async throws {
        let signatureGenerator = SCSignatureGenerator()
        let signature = try await signatureGenerator.downloadSignatureFromRemoteURL(url)
        try addReferenceSignature(signature, representing: mediaItems)
    }
    
    public func addRemoteCatalog(fromRemoteURL url: URL) async throws {
        do {
            let catalogTempURL = try await downloader.downloadFileFromURL(url)
            try add(from: catalogTempURL)
        } catch {
            throw error
        }
    }
    
    public func add(from url: URL) throws {
        do {
            try customShazamCatalog.add(from: url)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .customCatalogInvalidURL)
        }
    }
    
    public func write(to url: URL) throws {
        do {
            try customShazamCatalog.write(to: url)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .customCatalogSaveAttemptFailed)
        }
    }
    
    public func getCustomCatalog() -> SCCustomCatalog {
        return self
    }
}
