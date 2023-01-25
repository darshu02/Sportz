//
//  MatchViewModel.swift
//  SportzApp
//
//  Created by Darshika Patel on 25/01/23.
//

import Foundation

class MatchViewModel {
    
    var matchDetails: MatchDetails?
    
    func getData(completion: @escaping () -> Void) {
        NetworkManager.shared.getAllMatchesData(url: Constants.URLs.indVsNz) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                completion()
            case .success(let matchDetailsResult):
                self?.matchDetails = matchDetailsResult
                completion()
            }
        }
    }
    
    func getDate() -> String? {
        return matchDetails?.matchdetail.match.date
    }
    
    func getTime() -> String? {
        return matchDetails?.matchdetail.match.time
    }
    
    func getVenue() -> String? {
        return matchDetails?.matchdetail.venue.name
    }
    
    func getTeamsName() -> ([String], [String]) {
        
        var teamName = [String]()
        var teamShortName = [String]()
        
        if let keys = matchDetails?.teams.keys,
           let dict = matchDetails?.teams {
            
            for key in keys {
                if let team = dict[key] {
                    teamName.append(team.nameFull)
                    teamShortName.append(team.nameShort)
                }
            }
        }
        return (teamShortName, teamName)
    }
}
