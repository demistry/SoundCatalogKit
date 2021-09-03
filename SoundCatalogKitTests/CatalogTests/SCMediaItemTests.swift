//
//  SCMediaItemTests.swift
//  SCMediaItemTests
//
//  Created by David Ilenwabor on 03/09/2021.
//

import ShazamKit
import XCTest
@testable import SoundCatalogKit

class SCMediaItemTests: XCTestCase {
    private var mediaItem: SCMediaItem!
    private var matchedMediaItem: SCMatchedMediaItem!
    private var mediaItemProperty: SCMediaItemProperty!

    func test_mediaItemInitializer_succeeds() {
        mediaItem = SCMediaItem(properties: [.title: "testTitle", .shazamID: "TestID"])
        let expectedMediaItem = SHMediaItem(properties: [.title: "testTitle", .shazamID: "TestID"])
        XCTAssertEqual(expectedMediaItem[.title] as! String, mediaItem[.title] as! String)
        XCTAssertEqual(expectedMediaItem[.shazamID] as! String, mediaItem[.shazamID] as! String)
    }
    
    func test_mediaItemPropertyInitializer_succeeds() {
        mediaItemProperty = SCMediaItemProperty(rawValue: "TestProp")
        XCTAssertEqual(mediaItemProperty.rawValue, "TestProp")
        XCTAssertEqual(SCMediaItemProperty.shazamID.rawValue, SHMediaItemProperty.shazamID.rawValue)
    }
    
    func test_matchedMediaItemInitializer_succeeds() {
        matchedMediaItem = SCMatchedMediaItem(properties: [.title: "testTitle", .shazamID: "TestID"])
        let expectedMatchedMediaItem = SHMatchedMediaItem(properties: [.title: "testTitle", .shazamID: "TestID"])
        XCTAssertEqual(expectedMatchedMediaItem[.title] as! String, matchedMediaItem[.title] as! String)
        XCTAssertEqual(expectedMatchedMediaItem[.shazamID] as! String, matchedMediaItem[.shazamID] as! String)
    }
}
