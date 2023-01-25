//
//  PlayerDetailsViewController.swift
//  SportzApp
//
//  Created by Darshika Patel on 25/01/23.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerDetailsViewModel: PlayerDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDetailsViewModel?.setCurrentState(state: .All)
        tableView.reloadData()
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Select Category", message: "", preferredStyle: .actionSheet)
        let alertActionForAll = UIAlertAction(title: "All", style: .default) { _ in
            self.playerDetailsViewModel?.setCurrentState(state: .All)
            self.tableView.reloadData()
        }
        
        let actionForTeamA = UIAlertAction(title: "Team-A", style: .default) { _ in
            self.playerDetailsViewModel?.setCurrentState(state: .TeamA)
            self.tableView.reloadData()
        }
        
        let actionForTeamB = UIAlertAction(title: "Team-B", style: .default) { _ in
            self.playerDetailsViewModel?.setCurrentState(state: .TeamB)
            self.tableView.reloadData()
        }
        
        let actionForCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        alert.addAction(alertActionForAll)
        alert.addAction(actionForTeamA)
        alert.addAction(actionForTeamB)
        alert.addAction(actionForCancel)
        self.present(alert, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension PlayerDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        playerDetailsViewModel?.getSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        playerDetailsViewModel?.getSectionTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerDetailsViewModel?.getNumberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let player = playerDetailsViewModel?.cellForRowAtIndex(section: indexPath.section, index: indexPath.row),
           let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ViewControllerIndentifier.playerDetailsCell) as? PlayerDetailsCell {
            cell.setUpCell(player: player)
            return cell
        }
        return UITableViewCell.init()
    }
}
extension PlayerDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerDescription = playerDetailsViewModel?.didSelectRowAtIndex(section: indexPath.section, index: indexPath.row)
        let alert = UIAlertController(title: playerDetailsViewModel?.cellForRowAtIndex(section: indexPath.section, index: indexPath.row)?.nameFull, message: playerDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30.0
    }
    
}
