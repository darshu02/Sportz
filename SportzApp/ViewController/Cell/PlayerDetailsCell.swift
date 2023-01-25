//
//  PlayerDetailsCell.swift
//  SportzApp
//
//  Created by Darshika Patel on 25/01/23.
//

import UIKit

class PlayerDetailsCell: UITableViewCell {
    
    @IBOutlet weak var labelPlayerName: UILabel!
    @IBOutlet weak var labelWicketKeeper: UILabel!
    @IBOutlet weak var labelCaptain: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(player: Player) {
        labelPlayerName.text = player.nameFull
        labelWicketKeeper.text = (player.iskeeper ?? false) ? "WK" : ""
        labelCaptain.text = (player.iscaptain ?? false) ? "C" : ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
