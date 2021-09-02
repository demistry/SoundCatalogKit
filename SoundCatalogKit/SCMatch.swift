//
//  SCMatch.swift
//  SCMatch
//
//  Created by David Ilenwabor on 31/08/2021.
//

import Foundation
import ShazamKit

/// An object that represents the custom catalog media items that match a query.
///  
/// A single query signature may match more than one reference signature. In addition, one reference signature may map to many media items.
public class SCMatch: NSObject {
    private var match: SHMatch
    
    /// An array of the media items in the catalog that match the query signature, in order of the quality of the match.
    public var mediaItems: [SCMatchedMediaItem] {
        return match.mediaItems.map(SCMatchedMediaItem.init)
    }
    
    /// The query signature for the match.
    public var querySignature: SCSignature {
        return SCSignature(signature: match.querySignature)
    }
    
    init(match: SHMatch) {
        self.match = match
    }
}
