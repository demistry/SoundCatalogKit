//
//  SCSignatureGenerator.swift
//  SCSignatureGenerator
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

public protocol SCSignatureGeneratorDelegate: AnyObject {
    func signatureGenerator(_ signatureGenerator: SCSignatureGenerator,
                            failedToGenerateFromAudioInput error: Error
    )
}

public class SCSignatureGenerator {
    private var signatureGenerator: SHSignatureGenerator
    private lazy var streamer: SCMicStreamer = {
        let streamer = SCMicStreamer()
        return streamer
    }()
    
    private lazy var downloader: SCDownloader = {
        let downloader = SCDownloadManager()
        return downloader
    }()
    public weak var delegate: SCSignatureGeneratorDelegate?
    
    public init() {
        signatureGenerator = SHSignatureGenerator()
    }
    
    public func append(_ buffer: AVAudioPCMBuffer, at time: AVAudioTime?) throws {
        do {
            try signatureGenerator.append(buffer, at: time)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .invalidAudioFormat)
        }
    }
    
    public func generateSignatureFromAudioFile(
        withUrl audioURL: URL,
        andAudioFormat format: AVAudioFormat?
    ) throws {
        guard let audioFormat = format ?? AVAudioFormat(
            standardFormatWithSampleRate: Constants.defaultSampleRate,
            channels: 1
        ) else {
            return 
        }
        do {
            let audioFile = try AVAudioFile(forReading: audioURL)
            let outputBlock: ((AVAudioPCMBuffer) throws -> Void) = { [weak self] buffer in
                do {
                    try self?.append(buffer, at: nil)
                } catch {
                    throw SCError(
                        shError: error,
                        defaultErrorCode: .signatureDurationInvalid
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
    }
    
    public func generateSignatureFromAudioStream() throws {
        if streamer.isStreaming {
            return
        }
        print("Streaming....")
        streamer.delegate = self
        streamer.beginStreaming()
    }
    
    public func stopGeneratingSignatureFromAudioStream() {
        if streamer.isStreaming {
            streamer.delegate = nil
            streamer.endStreaming()
        }
    }
    
    public func downloadSignatureFromRemoteURL(
        _ url: URL,
        _ completion: @escaping (SCSignature?, Error?
        ) throws -> Void) {
        Task { 
            do {
                let signatureData = try await downloader.downloadDataFromURL(url)
                let signature = try SCSignature(dataRepresentation: signatureData)
                try completion(signature, nil)
            } catch {
                try completion(nil, error)
            }
        }
    }
    
    public func signature() -> SCSignature {
        return SCSignature(signature: signatureGenerator.signature())
    }
}

extension SCSignatureGenerator {
    private enum Constants {
        static let defaultSampleRate: Double = 44100
    }
}

extension SCSignatureGenerator: StreamerDelegate {
    func streamer(
        _ streamer: SCStreamer,
        didUpdateAudioStream buffer: AVAudioPCMBuffer,
        withTime time: AVAudioTime?
    ) {
        print("Streaming received...")
        try? self.append(buffer, at: time)
    }
    
    func streamer(_ streamer: SCStreamer, didFail error: Error) {
        delegate?.signatureGenerator(self, failedToGenerateFromAudioInput: error)
    }
}
