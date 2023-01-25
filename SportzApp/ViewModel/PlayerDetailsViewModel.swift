//
//  PlayerDetailsViewModel.swift
//  SportzApp
//
//  Created by Darshika Patel on 25/01/23.
//

import Foundation

enum PlayerDetailsViewState {
    case All
    case TeamA
    case TeamB
}

typealias NameAndPlayers = [String: [Player]]

class PlayerDetailsViewModel {
    
    // MARK: - Private properties
    
    private var currentState: PlayerDetailsViewState = .All {
        didSet {
            resetupData()
        }
    }
    
    /// Main data structue and do not temper(add, remove)
    private var mainDataSource = NameAndPlayers()
    
    /// Name of the participating teams and do not temper(add, remove)
    private var currentActiveTeams = [String]()
    
    // Sections for Tableview
    private var sections = [String]()
    
    /// Resetup the data after the state has been changed so that tableview can populate latest data
    private func resetupData() {
        guard !mainDataSource.isEmpty else { return }
        setupSectionsName()
    }
    
    // MARK: - Private functions
    
    private func setupSectionsName() {
        // Avoid duplicates
        self.sections.removeAll()
        
        switch currentState {
        case .All:
            sections = currentActiveTeams
            
        case .TeamA:
            // Only want First
            sections = [currentActiveTeams[0]]
            
        case .TeamB:
            // Only want second
            sections = [currentActiveTeams[1]]
        }
    }
    
    
    private func createTeamsDataStructure() {
        if let keys = matchDetails?.teams.keys,
           let dict = matchDetails?.teams {
            
            // keys will contain `[4, 5]`
            for key in keys {
                if let team = dict[key] {
                    
                    // Team will contain players but in the Dictionary format e.g. `[3632: Player]`
                    // We are interested in only `Player` from Dictionary
                    
                    let obj = getPlayers(from: team)
                    self.mainDataSource[obj.name] = obj.players
                }
            }
            // After `for-loop`, the `self.data` contains Dictionary i.e. `Countryname: [Players]`
        }
    }
    
    private func getPlayers(from team: Team) -> (name: String, players: [Player]) {
        let allkeys = team.players.keys
        let playersDictionary = team.players
        
        var players = [Player]()
        
        for key in allkeys {
            if let player =  playersDictionary[key] {
                players.append(player)
            }
        }
        currentActiveTeams.append(team.nameFull)
        // Return Tuple `(Country name, [Player])`
        return (team.nameFull, players)
    }
    
    private func getPlayerDetails(player: Player) -> String {
        let playerDescription = """
Bating:
Style: \(player.batting.style)
runs: \(player.batting.runs)
average: \(player.batting.average)
strikerate: \(player.batting.strikerate)

Bowling:
Style: \(player.bowling.style)
wickets: \(player.bowling.wickets)
average: \(player.bowling.average)
economyrate: \(player.bowling.economyrate)
"""
        return playerDescription
    }
    
    // MARK: - Public properties
    
    var matchDetails: MatchDetails? {
        didSet {
            // Only call this function once, as multiple time will do all processing again and result in duplication of data
            createTeamsDataStructure()
        }
    }
    
    // MARK: - Public functions
    
    func setCurrentState(state: PlayerDetailsViewState) {
        self.currentState = state
    }
    
    func isKeeper(player: Player) -> Bool {
        return player.iskeeper ?? false
    }
    
    func isCaptain(player: Player) -> Bool {
        return player.iscaptain ?? false
    }
    
    func getSections() -> Int {
        return self.sections.count
    }
    
    func getSectionTitle(section: Int) -> String {
        return self.sections[section]
    }
    
    func getNumberOfRows(section: Int) -> Int {
        switch currentState {
        case .All:
            let team1 = currentActiveTeams[0]
            let team2 = currentActiveTeams[1]
            return (section == 0) ? mainDataSource[team1]!.count : mainDataSource[team2]!.count
        case .TeamA:
            let team1 = currentActiveTeams[0]
            return mainDataSource[team1]!.count
        case .TeamB:
            let team2 = currentActiveTeams[1]
            return mainDataSource[team2]!.count
        }
    }
    
    func cellForRowAtIndex(section: Int, index: Int) -> Player? {
        let team1 = self.sections[section]
        if let players = mainDataSource[team1] {
            return players[index]
        }
        return nil
    }
    
    func didSelectRowAtIndex(section: Int, index: Int) -> String? {
        let sectionName = self.sections[section]
        if let players = mainDataSource[sectionName] {
            return getPlayerDetails(player: players[index])
        }
        return nil
    }
}
