//
//  SCDownloader.swift
//  SCDownloader
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation

protocol SCDownloader {
    func downloadDataFromURL(_ url: URL) async throws -> Data
    func downloadFileFromURL(_ url: URL) async throws -> URL
}
