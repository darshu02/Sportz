//
//  ViewController.swift
//  SportzApp
//
//  Created by Darshika Patel on 24/01/23.
//

import UIKit

class MatchViewController: UIViewController {
    
    @IBOutlet weak var labelNameShortForA: UILabel!
    @IBOutlet weak var labelNameFullForA: UILabel!
    @IBOutlet weak var labelNameShortForB: UILabel!
    @IBOutlet weak var labelNameFullForB: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelVenueName: UILabel!
    
    var matchViewModel = MatchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMatchDetailsData()
    }
    
    func getMatchDetailsData() {
        matchViewModel.getData {
            //Update UI from View Model
            DispatchQueue.main.async {
                self.setUpMatchData()
            }
        }
    }
    
    func setUpMatchData() {
        labelDate.text = matchViewModel.getDate()
        labelTime.text = matchViewModel.getTime()
        labelVenueName.text = matchViewModel.getVenue()
        let (teamNameShort, teamNameFull) = matchViewModel.getTeamsName()
        labelNameShortForA.text = teamNameShort[0]
        labelNameFullForA.text = teamNameFull[0]
        labelNameShortForB.text = teamNameShort[1]
        labelNameFullForB.text = teamNameFull[1]
    }
    
    @IBAction func playerDetailsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "PlayerDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerDetailsSegue",
           let playerDetailsVC = segue.destination as? PlayerDetailsViewController {
            
            // we have to pass `matchDetails` from `MatchViewModel` to `PlayerDetailsViewModel`.
            
            let playerViewModel = PlayerDetailsViewModel()
            playerViewModel.matchDetails = self.matchViewModel.matchDetails
            
            playerDetailsVC.playerDetailsViewModel = playerViewModel
        }
    }
}

