//
//  SCDownloadManager.swift
//  SCDownloadManager
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation

struct SCDownloadManager: SCDownloader {
    private let session = URLSession.shared
    func downloadCatalogFromURL(url: URL) async throws -> Data {
        let (localURL, _) = try await session.download(from: url)
        let data = try getDataFromURL(localURL)
        return data
    }
    
    private func getDataFromURL(_ url: URL) throws -> Data {
        let signatureData = try Data(contentsOf: url)
        return signatureData
    }
}
