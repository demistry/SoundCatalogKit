//
//  SCMediaItem.swift
//  SCMediaItem
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

/// An object that represents the metadata for a reference signature.
/// 
/// This class uses subscripting for the data elements of a custom media item that an existing property doesn’t already represent. 
/// Add a readable custom property by extending ``SCMediaItemProperty`` with a key for that property, and by extending this class with a property that uses the key.
public class SCMediaItem: NSObject {
    private(set) var mediaItem: SHMediaItem
    
    /// Creates a media item object with a dictionary of properties and their associated values.
    public init(properties: [SCMediaItemProperty: Any]) {
        let propertiesTuple = properties.map {
            (SHMediaItemProperty(rawValue: $0.key.rawValue), $0.value)
        }
        self.mediaItem = SHMediaItem(
            properties: Dictionary(uniqueKeysWithValues: propertiesTuple)
        )
    }
    
    /// Accesses the property for the specified key for reading.
    public subscript(key: SCMediaItemProperty) -> Any { 
        mediaItem[SHMediaItemProperty(rawValue: key.rawValue)]
    }
}
