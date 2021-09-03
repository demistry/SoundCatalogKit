//
//  SCCustomCatalogTests.swift
//  SCCustomCatalogTests
//
//  Created by David Ilenwabor on 02/09/2021.
//

import XCTest
@testable import SoundCatalogKit

class SCCustomCatalogTests: XCTestCase {
    private var customCatalog: SCCustomCatalog!
    private var mockDownloader: SCDownloaderMock!
    private var mediaItems: [SCMediaItem] = [SCMediaItem(properties: [.title: " TestKey"])]
    override func setUpWithError() throws {
        mockDownloader = SCDownloaderMock(isSuccessful: true)
        customCatalog = SCCustomCatalog(downloader: mockDownloader)
    }

    override func tearDownWithError() throws {
        customCatalog = nil
    }

    // MARK: Adding Reference signature
    func test_addReferenceSignature_succeeds() {
        let actualSignature = try! SCSignature(dataRepresentation: Data(contentsOf: Constants.FoodMathAudioSignatureURL))
        try! customCatalog.addReferenceSignature(actualSignature, representing: mediaItems)
    }
    
    func test_addReferenceSignature_fails() {
        let actualSignature = SCSignature()
        do {
            try customCatalog.addReferenceSignature(actualSignature, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Adding Reference data
    func test_addReferenceSignatureData_succeeds() {
        let actualData = try! Data(contentsOf: Constants.FoodMathAudioSignatureURL)
        try! customCatalog.addReferenceSignatureData(actualData, representing: mediaItems)
    }
    
    func test_addReferenceSignatureData_fails() {
        let actualData = "TestData".data(using: .utf8)!        
        do {
            try customCatalog.addReferenceSignatureData(actualData, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Adding From Audio File
    func test_addSignatureFromAudioFile_succeeds() {
        let actualURL = Constants.FoodMathAudioURL
        try! customCatalog.addSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil, representing: mediaItems)
    }
    
    func test_addSignatureFromAudioFile_fails() {
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalog.addSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Adding From Remote Signature File
    func test_addRemoteSignature_succeeds() async {
        let actualURL = Constants.FoodMathAudioSignatureURL
        try! await customCatalog.addRemoteSignature(fromRemoteURL: actualURL, representing: mediaItems)
    }
    
    func test_addRemoteSignature_fails() async {
        let actualURL = Constants.FoodMathAudioSignatureURL
        customCatalog = SCCustomCatalog(downloader: SCDownloaderMock(isSuccessful: false))
        do {
            try await customCatalog.addRemoteSignature(fromRemoteURL: actualURL, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Adding From Remote Catalog File
    func test_addRemoteCatalog_succeeds() async {
        let actualURL = Constants.FoodMathAudioCustomCatalogURL
        try! await customCatalog.addRemoteCatalog(fromRemoteURL: actualURL)
    }
    
    func test_addRemoteCatalog_fails() async {
        let actualURL = URL(string: "https://test.com")!        
        do {
            try await customCatalog.addRemoteCatalog(fromRemoteURL: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Adding Catalog from Local File
    
    func test_addCatalog_succeeds() {
        let actualURL = Constants.FoodMathAudioCustomCatalogURL
        try! customCatalog.add(from: actualURL)
    }
    
    func test_addCatalog_fails() {
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalog.add(from: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
    
    // MARK: Write Catalog as Local File
    
    func test_writeCatalog_fails() {
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalog.write(to: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
        }
    }
}
