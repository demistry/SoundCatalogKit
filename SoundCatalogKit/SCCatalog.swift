//
//  SHCatalog.swift
//  SHCatalog
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCReferenceCatalog: SCCatalog {
    private(set) var customCatalog: SHCustomCatalog
    
    public init() {
        customCatalog = SHCustomCatalog()
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
        url: URL,
        audioFormat: AVAudioFormat? = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
    ) {
//        guard let audioFormat = outputFormat else {
//            throw 
//        }
    }
    
    private func convertFromFile() {
//        let frameCount = AVAudioFrameCount(
//                (1024 * 64) / (audioFile.processingFormat.streamDescription.pointee.mBytesPerFrame)
//            )
//            let outputFrameCapacity = AVAudioFrameCount(
//                 round(Double(frameCount) * (outputFormat.sampleRate / audioFile.processingFormat.sampleRate))
//            )
//
//            guard let inputBuffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: frameCount),
//                  let outputBuffer = AVAudioPCMBuffer(pcmFormat: outputFormat, frameCapacity: outputFrameCapacity) else {
//                return
//            }
//
//            let inputBlock : AVAudioConverterInputBlock = { inNumPackets, outStatus in
//                do {
//                    try audioFile.read(into: inputBuffer)
//                    outStatus.pointee = .haveData
//                    return inputBuffer
//                } catch {
//                    if audioFile.framePosition >= audioFile.length {
//                        outStatus.pointee = .endOfStream
//                        return nil
//                    } else {
//                        outStatus.pointee = .noDataNow
//                        return nil
//                    }
//                }
//            }
//
//            guard let converter = AVAudioConverter(from: audioFile.processingFormat, to: outputFormat) else {
//                return
//            }
//
//            while true {
//
//                let status = converter.convert(to: outputBuffer, error: nil, withInputFrom: inputBlock)
//
//                if status == .error || status == .endOfStream {
//                    return
//                }
//
//                pcmBlock(outputBuffer)            
//
//                if status == .inputRanDry {
//                    return
//                }        
//
//                inputBuffer.frameLength = 0
//                outputBuffer.frameLength = 0
//            }
    }
    
    // Add for url
    // Add for writing to url
    // add for downloading catalog from url and take in optional media items
    // add for creating catalog
}
