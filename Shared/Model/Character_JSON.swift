//
//  Character_JSON.swift
//  StarWarsProject
//
//  Created by Jack Knight on 7/5/22.
//

import Foundation
import UIKit

// MARK: - Character
struct Character_JSON: Codable {
    let individuals: [StarWarsCharacter]
}

// MARK: - Individual
struct StarWarsCharacter: Codable {
    let id: Int
    let firstName, lastName, birthdate: String
    let profilePicture: String
    let forceSensitive: Bool
    let affiliation: String
}

class StarWarsCharacters : ObservableObject {
    static let shared = StarWarsCharacters()
    @Published var characters = [StarWarsCharacter]()
    
    func fetchStarWarsCharacters(callback: @escaping (Result<[StarWarsCharacter], NSError>) -> Void) {
        let request = HTTPRequest(method: .GET, urlString: NetworkHelper.baseURL)
        APICall(request) { response in
            if let error = response.error {
                print(error)
                callback(.failure(error as NSError))
            } else if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Character_JSON.self, from: data)
                    callback(.success(decoder.individuals))
                } catch let error {
                    print(error)
                    callback(.failure(error as NSError))
                }
            }
        }
    }
    
    func loadFrom(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = HTTPRequest(method: .GET, urlString: urlString)
        APICall(request) { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
            } else if let data = response.data {
                completion(.success(data))
            }
        }
    }
}
