//
//  SCSignatureGeneratorTests.swift
//  SCSignatureGeneratorTests
//
//  Created by David Ilenwabor on 02/09/2021.
//

import XCTest
@testable import SoundCatalogKit

class SCSignatureGeneratorTests: XCTestCase {
    private var signatureGenerator: SCSignatureGenerator!
    private var streamerMock: SCStreamerMock!
    private var downloaderMock: SCDownloaderMock!
    private var signatureGeneratorMock: SCSignatureGeneratorMock!
    override func setUpWithError() throws {
        streamerMock = SCStreamerMock()
        downloaderMock = SCDownloaderMock(isSuccessful: true)
        signatureGenerator = SCSignatureGenerator()
        signatureGeneratorMock = SCSignatureGeneratorMock(streamer: streamerMock, downloader: downloaderMock)
    }
    
    override func tearDownWithError() throws {
        signatureGenerator = nil
        streamerMock = nil
        downloaderMock = nil
    }

    func test_generateSignatureFromAudioStream_succeeds() {
        signatureGenerator = SCSignatureGenerator(streamer: streamerMock, downloader: downloaderMock)
        signatureGenerator.generateSignatureFromAudioStream()
        XCTAssertTrue(streamerMock.isStreaming)
        XCTAssertTrue(streamerMock.delegate === signatureGenerator)
        signatureGenerator.stopGeneratingSignatureFromAudioStream()
        XCTAssertFalse(streamerMock.isStreaming)
        XCTAssertTrue(streamerMock.delegate == nil)
    }
    
    func test_downloadSignatureFromRemoteURL_succeeds() async {
        let actualURL = URL(string: "http://test.com")!
        signatureGeneratorMock = SCSignatureGeneratorMock(streamer: streamerMock, downloader: downloaderMock)
        try! await signatureGeneratorMock.downloadSignatureFromRemoteURL(actualURL)
        XCTAssertEqual(signatureGeneratorMock.testData, "Test".data(using: .utf8)!)
    }
    
    func test_downloadSignatureFromRemoteURL_fails() async {
        let actualURL = URL(string: "http://test.com")!
        downloaderMock = SCDownloaderMock(isSuccessful: false)
        signatureGeneratorMock = SCSignatureGeneratorMock(streamer: streamerMock, downloader: downloaderMock)
        do {
            try await signatureGeneratorMock.downloadSignatureFromRemoteURL(actualURL)
        } catch {
            XCTAssertEqual(error as NSError, NSError(domain: "com.davidemi.soundcatalogkit", code: -1002, userInfo: [NSDebugDescriptionErrorKey: "Failed to download catalog/signature data from url"]))
        }
    }
    
    // MARK: Generate signature From Audio File
    func test_generateSignatureFromAudioFile_succeeds() {
        let actualURL = Bundle(for: type(of: self)).url(forResource: "FoodMathAudio", withExtension: "m4a")!
        try! signatureGenerator.generateSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil)
        let refSigURL = Bundle(for: type(of: self)).url(forResource: "AudioSignature", withExtension: "shazamsignature")!
        let expectedSignature = try! SCSignature(dataRepresentation: Data(contentsOf: refSigURL))
        XCTAssertEqual(signatureGenerator.signature().dataRepresentation, expectedSignature.dataRepresentation)
    }
    
    func test_addSignatureFromAudioFile_fails() {
        let actualURL = URL(string: "https://fakeurl.com")!        
        do {
            try signatureGenerator.generateSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(
                code: .invalidAudioFile, 
                description: "Could not read/convert audio file from url"
            ))
        }
    }

}
