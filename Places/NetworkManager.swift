//
//  NetworkManager.swift
//  Places
//
//  Created by Neil Madhavani on 12/12/20.
//

import Foundation
import Alamofire

class NetworkManager {

    // TODO: Edit our server host endpoint
    /* Helpful Hint: What is the host endpoint for our server?
     * Ex. If endpoint is "https://google.com/blah", Google is the host
     */
    private static let host = "https://places-backend-wk.herokuapp.com/"
    // TODO: Complete function to get a single restaurant
    static func signIn(email: String, username: String, password: String, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "username": username,
            "password": password
        ]
        let endpoint = "\(host)/users/login"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                print("Logged In")
                let jsonDecoder = JSONDecoder()
                if let user = try? jsonDecoder.decode(User.self, from: data) {
                    // Instructions: Use completion to handle response
                    DispatchQueue.main.async {
                        completion(user)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Function to add user
    static func addUser(email: String, username: String, password: String, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "username": username,
            "password": password
        ]
        let endpoint = "\(host)/users/register"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(_):
                print("created account")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Get all the places for the app
    static func getPlaces(completion: @escaping ([Place]) -> Void) {
        let endpoint = "https://places-backend-wk.herokuapp.com/places"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let placeData = try? jsonDecoder.decode([Place].self, from: data) {
                    completion(placeData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get Rating by id
    static func getRating(completion: @escaping (Int) -> Void) {
        let endpoint = "https://places-backend-wk.herokuapp.com/places/rating/2"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let ratingData = try? jsonDecoder.decode(Rating.self, from: data) {
                    // Instructions: Use completion to handle response
                    let rating = ratingData.rating
                    completion(rating)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

