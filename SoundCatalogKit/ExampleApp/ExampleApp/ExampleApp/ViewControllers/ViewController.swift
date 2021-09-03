//
//  ViewController.swift
//  ExampleApp
//
//  Created by David Ilenwabor on 03/09/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uiSwitch: UISwitch!
    private let actions = FrameworkActions.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActionsTableViewCell.nib, forCellReuseIdentifier: ActionsTableViewCell.identifier)
        tableView.reloadData()
    }
    @IBAction func playSongFromDeviceDuringMatch(_ sender: Any) {
        
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
        let action = actions[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActionsDetailsViewController") as! ActionsDetailsViewController
        vc.action = action
        vc.playAudioWhenMatchStarts = uiSwitch.isOn
        navigationController?.pushViewController(vc, animated: true)
    }
}

