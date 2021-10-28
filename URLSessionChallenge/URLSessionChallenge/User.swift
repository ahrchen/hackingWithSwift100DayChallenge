//
//  User.swift
//  URLSessionChallenge
//
//  Created by Raymond Chen on 10/24/21.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

func loadData(completion: @escaping ([User]) -> Void) {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
        print("Invalid URL")
        return
    }
    
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            let userDecoder = JSONDecoder()
            userDecoder.dateDecodingStrategy = .iso8601
            do {
                let decodedUsers = try userDecoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedUsers)
                }
                return
            } catch {
                print(error)

            }
            
        }
    }.resume()
}
