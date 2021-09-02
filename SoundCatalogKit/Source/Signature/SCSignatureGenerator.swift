//
//  SCSignatureGenerator.swift
//  SCSignatureGenerator
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

/// Used to send information on any error that occurs when generating a signature from an audio stream
public protocol SCSignatureGeneratorDelegate: AnyObject {
    func signatureGenerator(_ signatureGenerator: SCSignatureGenerator,
                            failedToGenerateFromAudioInput error: Error
    )
}

/// An object for converting audio data into a signature.
/// 
/// Create both reference and query signatures using this class.
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
    
    /// The object that the generator calls when an error occurs when generating a signature from an audio stream.
    public weak var delegate: SCSignatureGeneratorDelegate?
    
    /// Create an instance of an ``SCSignatureGenerator``
    public init() {
        signatureGenerator = SHSignatureGenerator()
    }
    
    /// Adds audio to the generator.
    /// 
    /// The audio must be PCM at one of these rates:
    /// 
    /// 48000 hertz
    /// 
    /// 44100 hertz
    /// 
    /// 32000 hertz
    /// 
    /// 16000 hertz
    /// 
    /// - Parameters:
    ///   - buffer: The audio data to append to the signature generator.
    ///   - format: The time position of the start of the audio buffer in the full audio you use to generate the signature.
    public func append(_ buffer: AVAudioPCMBuffer, at time: AVAudioTime?) throws {
        do {
            try signatureGenerator.append(buffer, at: time)
        } catch {
            throw SCError(shError: error, defaultErrorCode: .invalidAudioFormat)
        }
    }
    
    /// Creates a signature from an audio file.
    ///
    /// The audio must be PCM at one of these rates:
    /// 
    /// 48000 hertz
    /// 
    /// 44100 hertz
    /// 
    /// 32000 hertz
    /// 
    /// 16000 hertz
    /// 
    /// - Parameters:
    ///   - audioURL: The file URL for an audio file.
    ///   - format: The output format of the audio file after conversion.
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
    
    /// Starts generating a signature from a continous audio stream.
    /// 
    /// Signature keeps generating until ``stopGeneratingSignatureFromAudioStream()`` is called and the generator holds a reference to the signature generated up until this call is made.
    public func generateSignatureFromAudioStream() throws {
        if streamer.isStreaming {
            return
        }
        streamer.delegate = self
        streamer.beginStreaming()
    }
    
    /// Stops generating a signature from a continous audio stream.
    /// 
    /// Initializes generator with a generated signature if generation was ongoing  up until when this method is called.
    public func stopGeneratingSignatureFromAudioStream() {
        if streamer.isStreaming {
            streamer.delegate = nil
            streamer.endStreaming()
        }
    }
    
    /// Creates a reference signature from a remote source.
    ///
    /// Fetches the shazam signature file asynchronously.
    /// Ensure the url passed is a direct download reference to the .shazamsignature file on the remote server.
    ///
    /// - Parameters:
    ///   - url: The remote server URL of a Shazam signature file.
    ///   - Returns: The generated signature object if the fetch is successful
    public func downloadSignatureFromRemoteURL(_ url: URL) async throws -> SCSignature {
        let signatureData = try await downloader.downloadDataFromURL(url)
        let signature = try SCSignature(dataRepresentation: signatureData)
        return signature
    }
    
    /// Converts the audio buffer into a signature.
    public func signature() -> SCSignature {
        return SCSignature(signature: signatureGenerator.signature())
    }
}

extension SCSignatureGenerator {
    private enum Constants {
        static let defaultSampleRate: Double = 44100
    }
}

// MARK: - StreamerDelegate Implementation
extension SCSignatureGenerator: StreamerDelegate {
    func streamer(
        _ streamer: SCStreamer,
        didUpdateAudioStream buffer: AVAudioPCMBuffer,
        withTime time: AVAudioTime?
    ) {
        try? self.append(buffer, at: time)
    }
    
    func streamer(_ streamer: SCStreamer, didFail error: Error) {
        delegate?.signatureGenerator(self, failedToGenerateFromAudioInput: error)
    }
}
