//
//  SCAudioConverterTests.swift
//  SCAudioConverterTests
//
//  Created by David Ilenwabor on 03/09/2021.
//

import AVFAudio
import XCTest
@testable import SoundCatalogKit

class SCAudioConverterTests: XCTestCase {

    private var signatureGenerator: SCSignatureGenerator!
    override func setUpWithError() throws {
        signatureGenerator = SCSignatureGenerator()
    }

    override func tearDownWithError() throws {
        signatureGenerator = nil
    }

    func test_audioConverter_succeeds() throws {
        let audioFile = try! AVAudioFile(forReading: Constants.FoodMathAudioURL)
        let standardAudioFormat = AVAudioFormat(
            standardFormatWithSampleRate: 44100,
            channels: 1
        )!
        try! SCAudioConverter.convert(audioFile: audioFile, withOutputFormat: standardAudioFormat) { buffer in
            try! signatureGenerator.append(buffer, at: nil)
        }
        let actualSignature = signatureGenerator.signature()
        let expectedSignature = try! SCSignature(dataRepresentation: Data(contentsOf: Constants.FoodMathAudioSignatureURL)) 
        XCTAssertEqual(expectedSignature.dataRepresentation, actualSignature.dataRepresentation)
    }

}
