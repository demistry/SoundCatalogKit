//
//  FrameworkActions.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import Foundation

enum FrameworkActions: String, CaseIterable {
    
    // Custom Catalog Actions
    case AddReferenceSignatureToCatalog
    case AddReferenceSignatureFromAudioFile
    case AddCatalogFromRemote
    case AddReferenceSignatureFromRemote
    case AddCatalogFromLocalSource
    
    // Signature Generator Actions
    case DownloadSignatureFromURL
    case CreateSignatureFromAudioFile
    
    var description: String {
        switch self {
        case .AddReferenceSignatureToCatalog:
            return "Add reference signature from a Shazam signature file to a catalog"
        case .AddReferenceSignatureFromAudioFile:
            return "Add Reference signature directly from an audio file"
        case .AddCatalogFromRemote:
            return "Download a shazam catalog from a remote source"
        case .AddCatalogFromLocalSource:
            return "Add a shazam catalog from a local file"
        case .AddReferenceSignatureFromRemote:
            return "Download a shazam signature from a remote source and add to a catalog"
        case .DownloadSignatureFromURL:
            return "Download shazam signature from a remote source"
        case .CreateSignatureFromAudioFile:
            return "Create shazam signature from an audio file"
        }
    }
}
