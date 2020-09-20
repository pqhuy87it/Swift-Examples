//
//  Models.swift
//  Sample
//
//  Created by Exlinct on 11/5/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation

struct Movie {
    let name: String
}

extension Movie: Equatable {}

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.name == rhs.name
}

enum Rating {
    case Bad, Okay, Good
}

struct User {
    let name: String
    let email: String
}

extension User: Equatable {}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name && lhs.email == rhs.email
}

struct MovieRating {
    let rating: Rating
    let rater: User
    let movie: Movie
}

extension MovieRating: Equatable {}

func == (lhs: MovieRating, rhs: MovieRating) -> Bool {
    return lhs.rating == rhs.rating && lhs.rater == rhs.rater && lhs.movie == rhs.movie
}

enum DatabaseError: Error {
    case InvalidUser(User)
    case MoviePreviouslyRated(Movie)
    case DuplicateEmailAddress(String)
}

