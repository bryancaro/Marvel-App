//
//  Constants.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import Foundation
import CryptoSwift

enum Type: CustomStringConvertible {
    case comics
    case events
    case series
    
    var description: String {
        switch self {
        case .comics  : return "comics"
        case .events  : return "events"
        case .series  : return "series"
        }
    }
}

struct Constants {
    private static let MARVEL_PRIVATE_KEY = "fc218c39574e8e40b1471c1286ef315315ee7276"
    private static let MARVEL_PUBLIC_KEY  = "1b761101f364c224eadbc793df9883de"
    private static let ts                 = String(Date().timeIntervalSince1970)
    private static let hash               = "\(ts)\(MARVEL_PRIVATE_KEY)\(MARVEL_PUBLIC_KEY)".md5()
    
    private static let CHARGE_SERVER_HOST: String = "https://gateway.marvel.com:443/v1/public/characters"
    
    static let URL: String = "\(CHARGE_SERVER_HOST)?ts=\(ts)&apikey=\(MARVEL_PUBLIC_KEY)&hash=\(hash)"
    
    static let URL2 = { (id: Int, type: Type) -> String in
        return "\(CHARGE_SERVER_HOST)/\(id)/\(type)?ts=\(ts)&apikey=\(MARVEL_PUBLIC_KEY)&hash=\(hash)"
    }
}

/*
 GET /v1/public/characters/{characterId}/comics
 GET /v1/public/characters/{characterId}/events
 GET /v1/public/characters/{characterId}/series
 GET /v1/public/characters/{characterId}/stories
 */
