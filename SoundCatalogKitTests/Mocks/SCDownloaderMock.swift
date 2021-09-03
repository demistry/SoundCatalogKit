//
//  SCDownloaderMock.swift
//  SCDownloaderMock
//
//  Created by David Ilenwabor on 02/09/2021.
//

import Foundation
@testable import SoundCatalogKit

class SCDownloaderMock: SCDownloader {
    private var isSuccessful: Bool
    init(isSuccessful: Bool) {
        self.isSuccessful = isSuccessful
    }
    
    func downloadDataFromURL(_ url: URL) async throws -> Data {
        if isSuccessful {
            return "Test".data(using: .utf8)!
        } else {
            throw NSError(domain: "com.davidemi.soundcatalogkit", code: -1002, userInfo: [NSDebugDescriptionErrorKey: "Failed to download catalog/signature data from url"])
        }
    }
    
    func downloadFileFromURL(_ url: URL) async throws -> URL {
        if isSuccessful {
            return URL(string: "https://test.com")!
        } else {
            throw NSError(domain: "com.davidemi.soundcatalogkit", code: -1001, userInfo: [NSDebugDescriptionErrorKey: "Failed to download catalog/signature file from url"])
        }
    }
}
