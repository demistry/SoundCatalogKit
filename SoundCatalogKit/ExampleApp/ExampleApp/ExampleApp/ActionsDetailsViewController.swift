//
//  ActionsDetailsViewController.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import UIKit

class ActionsDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var text: UILabel!
    var action: FrameworkActions!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    @IBAction func startMatching(_ sender: Any) {
    }
    @IBAction func stopMatching(_ sender: Any) {
    }
}




