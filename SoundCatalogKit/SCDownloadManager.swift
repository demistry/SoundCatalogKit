//
//  SCDownloadManager.swift
//  SCDownloadManager
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation

struct SCDownloadManager: SCDownloader {
    private let session = URLSession.shared
    func downloadDataFromURL(_ url: URL) async throws -> Data {
        let localURL = try await downloadFileFromURL(url)
        let data = try getDataFromURL(localURL)
        return data
    }
    
    func downloadFileFromURL(_ url: URL) async throws -> URL {
        let (tempURL, _) = try await session.download(from: url)
        return tempURL
    }
    
    private func getDataFromURL(_ url: URL) throws -> Data {
        let data = try Data(contentsOf: url)
        return data
    }
}
