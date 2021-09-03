//
//  Shark.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import Foundation
import UIKit

struct SharkState: Comparable, Equatable {
    let title: String
    let offset: TimeInterval
    let image: UIImage? 
    
    
    static func < (lhs: SharkState, rhs: SharkState) -> Bool {
        return lhs.offset < rhs.offset
    }
    
    static func == (lhs: SharkState, rhs: SharkState) -> Bool {
        return lhs.title == rhs.title && lhs.offset == rhs.offset
    }
}

extension SharkState {
    static let allSharks = [
        SharkState(title: "LET'S GOOOO", offset: 0, image: UIImage.sharkFamily),
        SharkState(title: "BABY SHARK", offset: 2, image: UIImage.babyShark),
        SharkState(title: "MUMMY SHARK", offset: 11, image: UIImage.mummyShark),
        SharkState(title: "DADDY SHARK", offset: 19, image: UIImage.daddyShark),
        SharkState(title: "GRAND MA SHARK", offset: 28, image: UIImage.grandMaShark),
        SharkState(title: "GRAND PA SHARK", offset: 36, image: UIImage.grandPaShark),
        SharkState(title: "LETS GO HUNT", offset: 45, image: UIImage.letsGoHunt),
        SharkState(title: "RUNAWAY", offset: 53, image: UIImage.runaway),
        SharkState(title: "SAFE AT LAST", offset: 62, image: UIImage.safeAtLast),
        SharkState(title: "ITS THE END", offset: 70, image: UIImage.ItsTheEnd)
        ]
}
