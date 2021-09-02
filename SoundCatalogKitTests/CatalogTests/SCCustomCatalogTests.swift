//
//  SCCustomCatalogTests.swift
//  SCCustomCatalogTests
//
//  Created by David Ilenwabor on 02/09/2021.
//

import XCTest
@testable import SoundCatalogKit

class SCCustomCatalogTests: XCTestCase {
    private var customCatalogMock: SCCustomCatalogMock!
    private var mediaItems: [SCMediaItem] = [SCMediaItem(properties: [.title: " TestKey"])]
    override func setUpWithError() throws {
        customCatalogMock = SCCustomCatalogMock()
    }

    override func tearDownWithError() throws {
        customCatalogMock = nil
    }

    // MARK: Adding Reference signature
    func test_addReferenceSignature_succeeds() {
        customCatalogMock.isSuccessful = true
        let actualSignature = SCSignature()
        var expectedSignature: SCSignature!
        var expectedMediaItems: [SCMediaItem]!
        customCatalogMock.addedReferenceSignature = { signature, items in
            expectedSignature = signature
            expectedMediaItems = items
        }
        try! customCatalogMock.addReferenceSignature(actualSignature, representing: mediaItems)
        XCTAssertEqual(actualSignature, expectedSignature)
        XCTAssertEqual(expectedMediaItems[0][.title] as! String, mediaItems[0][.title] as! String)
    }
    
    func test_addReferenceSignature_fails() {
        customCatalogMock.isSuccessful = false
        let actualSignature = SCSignature()
        do {
            try customCatalogMock.addReferenceSignature(actualSignature, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .signatureInvalid, description: "Could not add reference signature"))
        }
    }
    
    // MARK: Adding Reference data
    func test_addReferenceSignatureData_succeeds() {
        customCatalogMock.isSuccessful = true
        let actualData = "TestData".data(using: .utf8)!
        var expectedData: Data!
        var expectedMediaItems: [SCMediaItem]!
        customCatalogMock.addedReferenceData = { data, items in
            expectedData = data
            expectedMediaItems = items
        }
        try! customCatalogMock.addReferenceSignatureData(actualData, representing: mediaItems)
        XCTAssertEqual(actualData, expectedData)
        XCTAssertEqual(expectedMediaItems[0][.title] as! String, mediaItems[0][.title] as! String)
    }
    
    func test_addReferenceSignatureData_fails() {
        customCatalogMock.isSuccessful = false
        let actualData = "TestData".data(using: .utf8)!        
        do {
            try customCatalogMock.addReferenceSignatureData(actualData, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .signatureInvalid, description: "Could not add reference signature data"))
        }
    }
    
    // MARK: Adding From Audio File
    func test_addSignatureFromAudioFile_succeeds() {
        customCatalogMock.isSuccessful = true
        let actualURL = URL(string: "https://test.com")!
        var expectedURL: URL!
        var expectedMediaItems: [SCMediaItem]!
        customCatalogMock.addedReferenceSignatureFromAudioFile = { url, items in
            expectedURL = url
            expectedMediaItems = items
        }
        try! customCatalogMock.addSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil, representing: mediaItems)
        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(expectedMediaItems[0][.title] as! String, mediaItems[0][.title] as! String)
    }
    
    func test_addSignatureFromAudioFile_fails() {
        customCatalogMock.isSuccessful = false
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalogMock.addSignatureFromAudioFile(withUrl: actualURL, andAudioFormat: nil, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .invalidAudioFile, description: "Could not add signature from audio file"))
        }
    }
    
    // MARK: Adding From Remote Signature File
    func test_addRemoteSignature_succeeds() async {
        customCatalogMock.isSuccessful = true
        let actualURL = URL(string: "https://test.com")!
        var expectedURL: URL!
        var expectedMediaItems: [SCMediaItem]!
        customCatalogMock.addedRemoteSignature = { url, items in
            expectedURL = url
            expectedMediaItems = items
        }
        try! await customCatalogMock.addRemoteSignature(fromRemoteURL: actualURL, representing: mediaItems)
        XCTAssertEqual(actualURL, expectedURL)
        XCTAssertEqual(expectedMediaItems[0][.title] as! String, mediaItems[0][.title] as! String)
    }
    
    func test_addRemoteSignature_fails() async {
        customCatalogMock.isSuccessful = false
        let actualURL = URL(string: "https://test.com")!        
        do {
            try await customCatalogMock.addRemoteSignature(fromRemoteURL: actualURL, representing: mediaItems)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .signatureInvalid, description: "Could not add signature from remote file"))
        }
    }
    
    // MARK: Adding From Remote Catalog File
    func test_addRemoteCatalog_succeeds() async {
        customCatalogMock.isSuccessful = true
        let actualURL = URL(string: "https://test.com")!
        var expectedURL: URL!
        customCatalogMock.addedRemoteCatalog = { url in
            expectedURL = url
        }
        try! await customCatalogMock.addRemoteCatalog(fromRemoteURL: actualURL)
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func test_addRemoteCatalog_fails() async {
        customCatalogMock.isSuccessful = false
        let actualURL = URL(string: "https://test.com")!        
        do {
            try await customCatalogMock.addRemoteCatalog(fromRemoteURL: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .customCatalogInvalid, description: "Could not add catalog from remote file"))
        }
    }
    
    // MARK: Adding Catalog from Local File
    func test_addCatalog_succeeds() {
        customCatalogMock.isSuccessful = true
        let actualURL = URL(string: "https://test.com")!
        var expectedURL: URL!
        customCatalogMock.addedCatalogFromURL = { url in
            expectedURL = url
        }
        try! customCatalogMock.add(from: actualURL)
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func test_addCatalog_fails() {
        customCatalogMock.isSuccessful = false
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalogMock.add(from: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .customCatalogInvalidURL, description: "Could not add catalog from local file"))
        }
    }
    
    // MARK: Write Catalog as Local File
    func test_writeCatalog_succeeds() {
        customCatalogMock.isSuccessful = true
        let actualURL = URL(string: "https://test.com")!
        var expectedURL: URL!
        customCatalogMock.wroteCatalogToURL = { url in
            expectedURL = url
        }
        try! customCatalogMock.write(to: actualURL)
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func test_writeCatalog_fails() {
        customCatalogMock.isSuccessful = false
        let actualURL = URL(string: "https://test.com")!        
        do {
            try customCatalogMock.write(to: actualURL)
        } catch {
            XCTAssertTrue(error is SCError)
            XCTAssertEqual(error as! SCError, SCError(code: .customCatalogSaveAttemptFailed, description: "Could not save catalog as local file"))
        }
    }
}
