//
//  SCSignatureTests.swift
//  SCSignatureTests
//
//  Created by David Ilenwabor on 03/09/2021.
//

import XCTest
@testable import SoundCatalogKit

class SCSignatureTests: XCTestCase {

    var signature: SCSignature!

    func test_initWithData_succeeds() {
        signature = try! SCSignature(dataRepresentation: Data(contentsOf: Constants.FoodMathAudioSignatureURL))
        let expectedSignature = try! SCSignature(dataRepresentation: Data(contentsOf: Constants.FoodMathAudioSignatureURL))
        XCTAssertEqual(signature.dataRepresentation, expectedSignature.dataRepresentation)
    }
}
