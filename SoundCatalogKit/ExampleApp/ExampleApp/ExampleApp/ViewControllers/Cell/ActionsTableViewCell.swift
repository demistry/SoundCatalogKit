//
//  ActionsTableViewCell.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import UIKit

class ActionsTableViewCell: UITableViewCell {

    static let identifier = "ActionsTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.main)
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellSubtitle: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    var action: FrameworkActions! {
        didSet {
            cellTitle.text = action.rawValue
            cellSubtitle.text = action.description
        }
    }
}
