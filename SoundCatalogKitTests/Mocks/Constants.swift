//
//  Constants.swift
//  Constants
//
//  Created by David Ilenwabor on 03/09/2021.
//

import Foundation

class Constants {
    static let shared = Constants()
    static let FoodMathAudioURL = Bundle(for: type(of: shared)).url(forResource: "BabyShark", withExtension: "m4a")!
    static let FoodMathAudioSignatureURL = Bundle(for: type(of: shared)).url(forResource: "BabyShark", withExtension: "shazamsignature")!
    static let FoodMathAudioCustomCatalogURL = Bundle(for: type(of: shared)).url(forResource: "BabyShark", withExtension: "shazamcatalog")!
    
    private init() {}
}
