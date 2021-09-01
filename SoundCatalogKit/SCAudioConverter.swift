//
//  SCAudioConverter.swift
//  SCAudioConverter
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import AVFAudio

struct SCAudioConverter {
    static func convert(
        audioFile: AVAudioFile,
        withOutputFormat outputFormat: AVAudioFormat,
        outputBlock: (AVAudioPCMBuffer) throws -> Void
    ) throws {
        let frameCount = AVAudioFrameCount(
                (1024 * 64) / (audioFile.processingFormat.streamDescription.pointee.mBytesPerFrame)
            )
        let outputFrameCapacity = AVAudioFrameCount(
             round(Double(frameCount) * (outputFormat.sampleRate / audioFile.processingFormat.sampleRate))
        )

        guard let inputBuffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: frameCount),
              let outputBuffer = AVAudioPCMBuffer(pcmFormat: outputFormat, frameCapacity: outputFrameCapacity) else {
            return
        }

        let inputBlock : AVAudioConverterInputBlock = { inNumPackets, outStatus in
            do {
                try audioFile.read(into: inputBuffer)
                outStatus.pointee = .haveData
                return inputBuffer
            } catch {
                if audioFile.framePosition >= audioFile.length {
                    outStatus.pointee = .endOfStream
                    return nil
                } else {
                    outStatus.pointee = .noDataNow
                    return nil
                }
            }
        }

        guard let converter = AVAudioConverter(from: audioFile.processingFormat, to: outputFormat) else {
            return
        }

        while true {
            let status = converter.convert(to: outputBuffer, error: nil, withInputFrom: inputBlock)
            if status == .error || status == .endOfStream {
                return
            }
            do {
                try outputBlock(outputBuffer)
            } catch {
                throw error
            }
            if status == .inputRanDry {
                return
            }        
            inputBuffer.frameLength = 0
            outputBuffer.frameLength = 0
        }
    }
}
