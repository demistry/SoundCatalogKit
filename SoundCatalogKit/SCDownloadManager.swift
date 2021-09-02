//
//  SCDownloadManager.swift
//  SCDownloadManager
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation

/// Download remote files for signature and catalog generation
struct SCDownloadManager: SCDownloader {
    private let session = URLSession.shared
    
    /// Download signature/catalog file from remote source as raw data
    /// 
    /// - Parameters:
    ///     - url: The remote url of the file
    /// - Returns: The raw data of the downloaded file
    func downloadDataFromURL(_ url: URL) async throws -> Data {
        let localURL = try await downloadFileFromURL(url)
        let data = try getDataFromURL(localURL)
        return data
    }
    
    /// Download signature/catalog file from remote source and return reference to temporary location of file
    /// 
    /// - Parameters:
    ///     - url: The remote url of the file
    /// - Returns: The temporary location of the downloaded file
    func downloadFileFromURL(_ url: URL) async throws -> URL {
        let (tempURL, _) = try await session.download(from: url)
        return tempURL
    }
    
    private func getDataFromURL(_ url: URL) throws -> Data {
        let data = try Data(contentsOf: url)
        return data
    }
}
