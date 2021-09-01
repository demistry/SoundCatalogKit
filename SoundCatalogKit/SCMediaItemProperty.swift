//
//  SCMediaItemProperty.swift
//  SCMediaItemProperty
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

public struct SCMediaItemProperty: Hashable, Equatable, RawRepresentable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

extension SCMediaItemProperty {

    /// The Shazam media ID
    public static let shazamID: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.shazamID.rawValue)

    /// Title
    public static let title: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.title.rawValue)

    /// Subtitle
    public static let subtitle: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.subtitle.rawValue)

    /// Artist
    public static let artist: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.artist.rawValue)

    /// A web URL representing this result
    public static let webURL: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.webURL.rawValue)
    
    /// A URL to the artwork
    public static let artworkURL: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.artworkURL.rawValue)

    /// A URL for a Video associated with the media
    public static let videoURL: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.videoURL.rawValue)

    /// Is this content explicit
    public static let explicitContent: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.explicitContent.rawValue)

    /// The International Standard Recording Code
    public static let ISRC: SCMediaItemProperty = SCMediaItemProperty(SHMediaItemProperty.ISRC.rawValue)
}
