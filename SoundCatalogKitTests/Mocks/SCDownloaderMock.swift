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
            return try Data(contentsOf: url)
        } else {
            throw NSError(domain: "com.davidemi.soundcatalogkit", code: -1002, userInfo: [NSDebugDescriptionErrorKey: "Failed to download catalog/signature data from url"])
        }
    }
    
    func downloadFileFromURL(_ url: URL) async throws -> URL {
        if isSuccessful {
            return url
        } else {
            throw NSError(domain: "com.davidemi.soundcatalogkit", code: -1001, userInfo: [NSDebugDescriptionErrorKey: "Failed to download catalog/signature file from url"])
        }
    }
}
