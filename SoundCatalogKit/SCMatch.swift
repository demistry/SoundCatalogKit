//
//  SCMatch.swift
//  SCMatch
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

public class SCMatch: NSObject {
    private var match: SHMatch
    public var mediaItems: [SCMatchedMediaItem] {
        match.mediaItems.map(SCMatchedMediaItem.init)
    }
    
    init(match: SHMatch) {
        self.match = match
    }
}
