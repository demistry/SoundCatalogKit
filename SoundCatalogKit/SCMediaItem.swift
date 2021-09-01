//
//  SCMediaItem.swift
//  SCMediaItem
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

public class SCMediaItem: NSObject {
    
    private(set) var mediaItem: SHMediaItem
    
    public init(properties: [SCMediaItemProperty: Any]) {
        let propertiesTuple = properties.map{ (SHMediaItemProperty(rawValue: $0.key.rawValue), $0.value) }
        self.mediaItem = SHMediaItem(properties: Dictionary(uniqueKeysWithValues: propertiesTuple))
    }
    
    public subscript(key: SCMediaItemProperty) -> Any { 
        mediaItem[SHMediaItemProperty(rawValue: key.rawValue)]
    }
}
