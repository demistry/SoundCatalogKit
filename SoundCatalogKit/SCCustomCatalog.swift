//
//  SHCatalog.swift
//  SHCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

/// Configure a custom catalog of ``SCSignature`` objects to match against.
///
/// Use a custom catalog if you intend to search against reference signatures that you have provided yourself. All matches will be performed locally on the device against the signatures added to this Catalog.
/// ``SCMediaItem`` can be built using custom data that will be returned when a match is made.
/// Once this catalog has been built it can be written to disk and loaded again at a later date. 
public class SCCustomCatalog: SCCatalog {
    
    private(set) var customShazamCatalog: SHCustomCatalog
    private var downloader: SCDownloader {
        return SCDownloadManager()
    }
    
    /// Creates a new custom catalog object for storing reference audio signatures and their associated metadata.
    public init() {
        customShazamCatalog = SHCustomCatalog()
    }
    
    /// Adds a reference signature and its associated metadata to a catalog.
    ///
    /// > Note: This system ignores calls to addReferenceSignature(_:representing:) after adding the catalog to an `SHSession.
    ///
    /// - Parameters:
    ///   - referenceSignature: The reference signature for the audio recording.
    ///   - mediaItems: The metadata for the recording.
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

    /// Creates a reference signature from its raw data and adds it with its associated metadata to a catalog.
    ///
    /// > Note: This system ignores calls to addReferenceSignatureData(_:representing:) after adding the catalog to an `SCSession.
    ///
    /// - Parameters:
    ///   - referenceData: The raw data that makes up the signature.
    ///   - mediaItems: The metadata for the recording.
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
    
    /// Creates a reference signature from its raw data and adds it with its associated metadata to a catalog.
    ///
    /// - Parameters:
    ///   - audioURL: The file URL for an audio file.
    ///   - format: The output format of the audio file after conversion.
    ///   - mediaItems: The metadata for the recording.
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
    
    /// Creates a reference signature from a remote source and adds it with its associated metadata to a catalog.
    ///
    /// Fetches the shazam signature file asynchronously.
    /// Ensure the url passed is a direct download reference to the .shazamsignature file on the remote server.
    ///
    /// - Parameters:
    ///   - url: The remote server URL of a Shazam signature file.
    ///   - mediaItems: The metadata for the recording.
    public func addRemoteSignature(
        fromRemoteURL url: URL,
        representing mediaItems: [SCMediaItem]
    ) async throws {
        let signatureGenerator = SCSignatureGenerator()
        let signature = try await signatureGenerator.downloadSignatureFromRemoteURL(url)
        try addReferenceSignature(signature, representing: mediaItems)
    }
    
    /// Creates a custom catalog from a remote source.
    ///
    /// Fetches the shazam catalog file asynchronously.
    /// Ensure the url passed is a direct download reference to the .shazamcatalog file on the remote server.
    ///
    /// - Parameters:
    ///   - url: The remote server URL of a Shazam catalog file.
    public func addRemoteCatalog(fromRemoteURL url: URL) async throws {
        do {
            let catalogTempURL = try await downloader.downloadFileFromURL(url)
            try add(from: catalogTempURL)
        } catch {
            throw error
        }
    }
    
    /// Loads a saved custom catalog from a file.
    /// 
    /// - Parameters:
    ///     - sourceURL: A URL for the saved custom catalog file.
    public func add(from sourceURL: URL) throws {
        do {
            try customShazamCatalog.add(from: sourceURL)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .customCatalogInvalidURL)
        }
    }
    
    /// Saves the custom catalog to a local file.
    /// 
    /// If destinationURL is a directory, the system creates a Signatures.shazamcatalog file.
    /// 
    /// - Parameters:
    ///     - destinationURL: A URL for the saved custom catalog file.
    public func write(to destinationURL: URL) throws {
        do {
            try customShazamCatalog.write(to: destinationURL)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .customCatalogSaveAttemptFailed)
        }
    }
    
    /// Retrieves the current ``SCCustomCatalog`` instance.
    /// 
    /// - Returns: The current instance of the object.
    public func getCustomCatalog() -> SCCustomCatalog {
        return self
    }
}
