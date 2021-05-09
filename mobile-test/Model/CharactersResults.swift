//
//  Characters.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import Foundation

struct CharactersResults: Codable  {
    var data: Characters
}

struct Characters: Codable {
    var count  : Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id          : Int
    var name        : String
    var description : String
    var thumbnail   : [String: String]
    var urls        : [[String: String]]
}
