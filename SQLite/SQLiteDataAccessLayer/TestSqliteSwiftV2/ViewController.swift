//
//  ViewController.swift
//  TestSqliteSwiftV2
//
//  Created by Jon Hoffman on 7/28/15.
//  Copyright © 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dataStore = SQLiteDataStore.sharedInstance
        do {
            try dataStore.createTables()
            setData()
        } catch _ {}
        
        print("Finish")
        
    }
    
    func setData() {
        do {
            let bosId = try TeamDataHelper.insert(
                Team(
                    teamId: 0,
                    city: "Boston",
                    nickName: "Red Sox",
                    abbreviation: "BOS"))
            print(bosId)
            
            let ortizId = try PlayerDataHelper.insert(
                Player(
                    playerId: 0,
                    firstName: "David",
                    lastName: "Ortiz",
                    number: 34,
                    teamId: bosId,
                    position: Positions.DesignatedHitter
            ))
            print(ortizId)
            
            let bogeyId = try PlayerDataHelper.insert(
                Player(
                    playerId: 0,
                    firstName: "Xander",
                    lastName: "Bogarts",
                    number: 2,
                    teamId: bosId,
                    position: Positions.Shortstop
                ))
            print(bogeyId)
            
        } catch _{}
        
        do {
            let baltId = try TeamDataHelper.insert(
                Team(
                    teamId: 0,
                    city: "Baltimore",
                    nickName: "Orioles",
                    abbreviation: "BAL"))
            print(baltId)
        } catch _ {}
        
        do {
            let tampId = try TeamDataHelper.insert(
                Team(
                    teamId: 0,
                    city: "Tampa Bay",
                    nickName: "Rays",
                    abbreviation: "TB"))
            print(tampId)
        } catch _ {}
        
        do {
            let torId = try TeamDataHelper.insert(
                Team(
                    teamId: 0,
                    city: "Toronto",
                    nickName: "Blue Jays",
                    abbreviation: "TOR"))
            print(torId)
        } catch _ {}
        
        do {
            if let teams = try TeamDataHelper.findAll() {
                for team in teams {
                    print("\(team.city!) \(team.nickName!)")
                    try TeamDataHelper.delete(team)
                }
            }
        } catch _ {}
        
    }
    
    func setPlayers() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

