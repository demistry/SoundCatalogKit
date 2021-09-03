//
//  SCSessionTests.swift
//  SCSessionTests
//
//  Created by David Ilenwabor on 03/09/2021.
//

import XCTest
@testable import SoundCatalogKit
import ShazamKit

class SCSessionTests: XCTestCase, SCSessionDelegate {
    private var session: SCSession!
    private var streamerMock: SCStreamerMock!
    private var sessionResultSource: SCSessionResultSource!
    override func setUpWithError() throws {
        sessionResultSource = SCSessionResultSource()
        streamerMock = SCStreamerMock()
        session = SCSession(streamer: streamerMock)
        session.delegate = self
        sessionResultSource.delegate = session
    }
    
    override func tearDownWithError() throws {
        session = nil
        sessionResultSource = nil
        streamerMock = nil
        XCTAssertNil(session?.delegate)
        XCTAssertNil(sessionResultSource?.delegate)
    }

    func test_sessionStartedMatching_succeeds() {
        session.startMatching()
        XCTAssertTrue(streamerMock.isStreaming)
    }
    
    func test_sessionStartedMatching_fails() {
        session.startMatching()
        streamerMock.streamingFailed?(SCError(code: .audioEngineFailed, description: "Audio engine failed to start"))
    }
    
    func test_sessionStoppedMatching_succeeds() {
        session.stopMatching()
        XCTAssertFalse(streamerMock.isStreaming)
    }

    func session(_ session: SCSession, didFind match: SCMatch) {
        XCTAssertEqual(session, self.session)
    }
    
    func sessionDidStartMatch(_ session: SCSession) {
        XCTAssertEqual(session, self.session)
    }
    
    func sessionDidStopMatch(_ session: SCSession) {
        XCTAssertEqual(session, self.session)
    }
    
    func session(_ session: SCSession, failedToMatchDueTo error: Error) {
        let expectedError = SCError(code: .audioEngineFailed, description: "Audio engine failed to start")
        XCTAssertEqual(session, self.session)
        XCTAssertTrue(error is SCError)
        XCTAssertEqual(error as! SCError, expectedError)
    }

}
