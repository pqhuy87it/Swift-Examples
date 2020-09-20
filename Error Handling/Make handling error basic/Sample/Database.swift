//
//  Database.swift
//  Sample
//
//  Created by Exlinct on 11/5/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation

class Database {
    private(set) var users: [User] = []
    private(set) var movies: [Movie] = []
    private(set) var ratings: [MovieRating] = []
    
    func createUser(withName name: String, email: String) throws -> User {
        let userEmails = users.map { $0.email }
        
        if userEmails.contains(email) {
            throw DatabaseError.DuplicateEmailAddress(email)
        }
        
        let newUser = User(name: name, email: email)
        users.append(newUser)
        return newUser
    }
    
    
    func add(movie: Movie, withRating rating: Rating, forUser user: User) throws {
        if !users.contains(user) {
            throw DatabaseError.InvalidUser(user)
        }
        
        let userRatedMovies = ratings.filter { $0.rater == user }.map { $0.movie }
        if userRatedMovies.contains(movie) {
            throw DatabaseError.MoviePreviouslyRated(movie)
        }
        
        if !movies.contains(movie) {
            movies.append(movie)
        }
        ratings.append(MovieRating(rating: rating, rater: user, movie: movie))
    }
}
