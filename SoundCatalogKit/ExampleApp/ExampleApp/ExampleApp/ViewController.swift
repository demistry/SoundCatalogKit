//
//  ViewController.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import SoundCatalogKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let actions = FrameworkActions.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Actions"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActionsTableViewCell.nib, forCellReuseIdentifier: ActionsTableViewCell.identifier)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionsTableViewCell.identifier, for: indexPath) as! ActionsTableViewCell
        cell.action = actions[indexPath.row]
        cell.itemNumber.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

