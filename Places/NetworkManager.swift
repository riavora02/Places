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
    
    // TODO: Complete function to get a single restaurant
    static func signIn(email: String, password: String, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        let endpoint = "localhost:5004/users/login"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
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
    static func addUser(email: String, password: String, completion: @escaping ([User]) -> Void) {
        let endpoint = "localhost:5004/users/register"
        AF.request(endpoint, method: .get, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let userData = try? jsonDecoder.decode(UsersDataResponse.self, from: data) {
                    DispatchQueue.main.async {
                        completion(userData.users)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

