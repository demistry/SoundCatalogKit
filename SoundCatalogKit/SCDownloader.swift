//
//  SCDownloader.swift
//  SCDownloader
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation

protocol SCDownloader {
    func downloadCatalogFromURL(url: URL) async throws -> Data
}
