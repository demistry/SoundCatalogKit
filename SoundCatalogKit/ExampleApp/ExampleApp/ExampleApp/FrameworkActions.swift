//
//  FrameworkActions.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import Foundation

enum FrameworkActions: String, CaseIterable {
    
    // Session
    case MatchMicrophoneToCustomCatalog
    
    // Custom Catalog Actions
    case AddReferenceSignatureToCatalog
    case AddReferenceSignatureDataToCatalog
    case AddReferenceSignatureFromAudioFile
    case AddCatalogFromRemote
    case AddReferenceSignatureFromRemote
    case AddCatalogFromURL
    case SaveCatalogToURL
    
    // Signature Actions
    case SaveSignatureToURL
    
    // Signature Generator Actions
    
    case CreateSignatureFromAudioStream
    case DownloadSignatureFromURL
    case CreateSignatureFromAudioFile
    
    var description: String {
        switch self {
        case .MatchMicrophoneToCustomCatalog:
            return "Match Microphone audio of iOS device to a custom catalog"
        case .AddReferenceSignatureToCatalog:
            return "Add Reference signature to a catalog"
        case .AddReferenceSignatureDataToCatalog:
            return "Add Reference signature data to a catalog"
        case .AddReferenceSignatureFromAudioFile:
            return "Add Reference signature directly from an audio file"
        case .AddCatalogFromRemote:
            return "Download a catalog from a remote source"
        case .AddReferenceSignatureFromRemote:
            return "Download a signature from a remote source and add to a catalog"
        case .AddCatalogFromURL:
            return "Add catalog from a local url"
        case .SaveCatalogToURL:
            return "Save catalog to device"
        case .SaveSignatureToURL:
            return "Save signature to device"
        case .CreateSignatureFromAudioStream:
            return "Create signature from microphone audio"
        case .DownloadSignatureFromURL:
            return "Download signature from a remote source"
        case .CreateSignatureFromAudioFile:
            return "Create signature from an audio file"
        }
    }
}
