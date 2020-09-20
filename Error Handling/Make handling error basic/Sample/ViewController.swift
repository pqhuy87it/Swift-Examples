//
//  ViewController.swift
//  Sample
//
//  Created by Exlinct on 11/5/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createDatabase()
    }

    func createDatabase() {

        let db = Database()
        
        do {
            _ = try db.createUser(withName: "Alana", email: "alana@example.com")
        } catch DatabaseError.DuplicateEmailAddress(let email) {
            print("\(email) already exists in the database.")
        } catch let unknownError {
            print("\(unknownError) is an unknown error.")
        }

        
        do {
            let alana = try db.createUser(withName: "Alana", email: "alana@example.com")
            let darko = Movie(name: "Donnie Darko")
            try db.add(movie: darko, withRating: .Good, forUser: alana)
        } catch DatabaseError.DuplicateEmailAddress(let email) {
            print("\(email) already exists in the database.")
        } catch DatabaseError.InvalidUser(let user) {
            print("\(user) is not in the database.")
        } catch DatabaseError.MoviePreviouslyRated(let movie) {
            print("User has already rated \(movie.name)")
        } catch let unknownError {
            print("\(unknownError) is an unknown error.")
        }
    }
}

