//
//  SCMatchedMediaItem.swift
//  SCMatchedMediaItem
//
//  Created by David Ilenwabor on 01/09/2021.
//

import Foundation
import ShazamKit

/// An object that represents the metadata for a matched reference signature.
/// 
/// To access properties for custom media items, use subscripting. For more information, see ``SCMediaItem``.
public class SCMatchedMediaItem: SCMediaItem {
    private var matchedMediaItem: SHMatchedMediaItem
    
    /// The updated timecode in the reference recording that matches the current playback position of the query audio, in seconds.
    public var predictedCurrentMatchOffset: TimeInterval {
        matchedMediaItem.predictedCurrentMatchOffset
    }
    
    /// A multiple for the difference in frequency between the matched audio and the query audio.
    public var frequencySkew: Float { 
        matchedMediaItem.frequencySkew
    }
    
    /// The timecode in the reference recording that matches the start of the query, in seconds.
    public var matchOffset: TimeInterval { 
        matchedMediaItem.matchOffset
    }
    
    /// Creates a media item object with a dictionary of properties and their associated values.
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
