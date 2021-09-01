//
//  SCMatchedMediaItem.swift
//  SCMatchedMediaItem
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

public class SCMatchedMediaItem: SCMediaItem {
    private var matchedMediaItem: SHMatchedMediaItem
    
    public var predictedCurrentMatchOffset: TimeInterval {
        matchedMediaItem.predictedCurrentMatchOffset
    }
    
    public var frequencySkew: Float { 
        matchedMediaItem.frequencySkew
    }
    
    public var matchOffset: TimeInterval { 
        matchedMediaItem.matchOffset
    }
    
    public override init(properties: [SCMediaItemProperty: Any]) {
        let propertiesTuple = properties.map {
            (SHMediaItemProperty(rawValue: $0.key.rawValue), $0.value) 
        }
        self.matchedMediaItem = SHMatchedMediaItem(
            properties: Dictionary(uniqueKeysWithValues: propertiesTuple)
        )
        super.init(properties: properties)
    }
    
    init(matchedMediaItem: SHMatchedMediaItem) {
        self.matchedMediaItem = matchedMediaItem
        super.init(properties: [:])
    }
}
