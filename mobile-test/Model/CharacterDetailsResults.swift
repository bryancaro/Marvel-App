//
//  Comics.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/9/21.
//

import Foundation

struct CharacterDetailsResults: Codable  {
    var data: Details
}

struct Details: Codable {
    var count   : Int
    var results : [Detail]
}

struct Detail: Identifiable, Codable {
    var id          : Int
    var title       : String
    var description : String?
    var thumbnail   : [String: String]
    var creators    : Creators
}

struct Creators: Codable {
    var items   : [Creator]
}

struct Creator: Codable {
    var name : String
    var role : String
    var resourceURI : String
}
