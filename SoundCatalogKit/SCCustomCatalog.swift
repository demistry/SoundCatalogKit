//
//  SHCatalog.swift
//  SHCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCCustomCatalog: SCCatalog {

    private(set) var customCatalog: SHCustomCatalog
    private var streamer: SCStreamer
    
    public init() {
        customCatalog = SHCustomCatalog()
        streamer = SCMicStreamer()
    }
    
    convenience init(streamer: SCStreamer) {
        self.init()
        self.streamer = streamer
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
            throw SCError(shError: error, defaultErrorCode: .SCErrorCodeSignatureInvalid)
        }
    }

    public func addReferenceSignatureData(
        _ referenceData: Data,
        representing mediaItems: [SCMediaItem]
    ) throws {
        do {
            let signature = try SHSignature(dataRepresentation: referenceData)
            try customCatalog.addReferenceSignature(
                signature,
                representing: mediaItems.map({ $0.mediaItem }))
        } catch {
            throw SCError(shError: error, defaultErrorCode: .SCErrorCodeSignatureInvalid)
        }
    }
    
    public func addSignatureFromAudioFile(
        withUrl audioURL: URL,
        andAudioFormat format: AVAudioFormat?,
        representing mediaItems: [SCMediaItem]
    ) throws {
        guard let audioFormat = format ?? AVAudioFormat(
            standardFormatWithSampleRate: Constants.defaultSampleRate,
            channels: 1
        ) else {
            return 
        }
        
        let signatureGenerator = SHSignatureGenerator()
        
        do {
            let audioFile = try AVAudioFile(forReading: audioURL)
            let outputBlock: ((AVAudioPCMBuffer) throws -> Void) = { buffer in
                do {
                    try signatureGenerator.append(buffer, at: nil)
                } catch {
                    throw SCError(
                        shError: error,
                        defaultErrorCode: .SCErrorCodeSignatureDurationInvalid
                    )
                }
            }
            try SCAudioConverter.convert(
                audioFile: audioFile,
                withOutputFormat: audioFormat,
                outputBlock: outputBlock
            )
        } catch {
            throw SCError(
                code: .invalidAudioFile, 
                description: "Could not read/convert audio file from url"
            )
        }
        try addReferenceSignature(
            SCSignature(signature: signatureGenerator.signature()),
            representing: mediaItems
        )
    }
    
    public func add(from url: URL) throws {
        do {
            try customCatalog.add(from: url)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .SCErrorCodeCustomCatalogInvalidURL)
        }
    }
    
    public func write(to url: URL) throws {
        do {
            try customCatalog.write(to: url)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .customCatalogSaveAttemptFailed)
        }
    }
    // add for downloading catalog from url and take in optional media items
}
extension SCCustomCatalog {
    private enum Constants {
        static let defaultSampleRate: Double = 44100
    }
}
