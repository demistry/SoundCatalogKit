//
//  SCSignatureMock.swift
//  SCSignatureMock
//
//  Created by David Ilenwabor on 03/09/2021.
//

import AVFAudio
import Foundation
@testable import SoundCatalogKit

class SCSignatureGeneratorMock: SCSignatureGenerator {
    var isSuccessful: Bool = true
    var didAddSignatureFromAudioFile: ((URL) -> Void)?
    var testSignature: SCSignature!
    var testData: Data!
    private var mockDownloader: SCDownloaderMock!
    init(streamer: SCStreamer, downloader: SCDownloaderMock) {
        self.mockDownloader = downloader
        super.init(streamer: streamer, downloader: downloader)
    }
    
    override func generateSignatureFromAudioFile(withUrl audioURL: URL, andAudioFormat format: AVAudioFormat?) throws {
        if isSuccessful {
            self.testSignature = signature()
            didAddSignatureFromAudioFile?(audioURL)
        } else {
            throw SCError(
                code: .invalidAudioFile, 
                description: "Could not read/convert audio file from url"
            ) 
        }
    }
    
    @discardableResult
    override func downloadSignatureFromRemoteURL(_ url: URL) async throws -> SCSignature {
        testData = try await mockDownloader.downloadDataFromURL(url)
        return signature()
    }
}
