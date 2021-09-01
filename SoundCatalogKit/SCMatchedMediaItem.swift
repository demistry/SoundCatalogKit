//
//  SCMatchedMediaItem.swift
//  SCMatchedMediaItem
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

class SCMatchedMediaItem {
    private var matchedMediaItem: SHMatchedMediaItem
    
    public init(properties: [SCMediaItemProperty: Any]) {
        let propertiesTuple = properties.map{ (SHMediaItemProperty(rawValue: $0.key.rawValue), $0.value) }
        self.matchedMediaItem = SHMatchedMediaItem(properties: Dictionary(uniqueKeysWithValues: propertiesTuple))
    }
}
