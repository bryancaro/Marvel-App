//
//  ChargeAPI.swift
//  mobile-test
//
//  Created by Bryan Caro on 5/7/21.
//

import Foundation

class ChargeAPI {
    static public func retrieveCharacters(completion: @escaping (CharactersResults?, Error?) -> Void) {
        let url = URL(string: Constants.URL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response else {
                print("algo paso, \(error?.localizedDescription)")
                completion(nil, error)
                return
            }
            let httpResponse2 = httpResponse as! HTTPURLResponse
            print("API RESPONSE CODE: \(httpResponse2.statusCode)")
            
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain {
                    print("contact host error")
                    completion(nil, error)
                } else {
                    print("something went wrong")
                    completion(nil, error)
                }
            }
            
            guard let data = data else {
                print("No data fetched")
                return
            }
            
            let decoder = JSONDecoder()

            do {
                let characters = try decoder.decode(CharactersResults.self, from: data)
                completion(characters, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
    }
    
    static public func retrieveCharacterDetails(id: Int, type: Type, completion: @escaping (CharacterDetailsResults?, Error?) -> Void) {
        let url = URL(string: Constants.URL2(id, type))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response else {
                print("algo paso, \(error?.localizedDescription)")
                completion(nil, error)
                return
            }
            let httpResponse2 = httpResponse as! HTTPURLResponse
            print("API RESPONSE CODE: \(httpResponse2.statusCode)")
            
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain {
                    print("contact host error")
                    completion(nil, error)
                } else {
                    print("something went wrong")
                    completion(nil, error)
                }
            }
            
            
            guard let data = data else {
                print("No data fetched")
                return
            }
            
            let decoder = JSONDecoder()

            do {
                let details = try decoder.decode(CharacterDetailsResults.self, from: data)
                completion(details, nil)
                
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
    }
}


/*
 GET /v1/public/characters/{characterId}/comics
 GET /v1/public/characters/{characterId}/events
 GET /v1/public/characters/{characterId}/series
 GET /v1/public/characters/{characterId}/stories
 
 */
