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
    static func getRating(id: Int, completion: @escaping (Int) -> Void) {
        let endpoint = "https://places-backend-wk.herokuapp.com/places/rating/\(id)"
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
    
    static func addReview(userID: Int, placeID: Int, rating: Int, text: String, completion: @escaping (User) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + User.current!.session_token
        ]
        let parameters: [String: Any] = [
            "user_id": userID,
            "place_id": placeID,
            "rating": rating,
            "text": text,
        ]
        let endpoint = "https://places-backend-wk.herokuapp.com/reviews"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseData { response in
            switch response.result {
            case .success(_):
                print("posted review")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // get the Reviews
    static func getReviews(place: Int, completion: @escaping ([Review]) -> Void) {
        let endpoint = "https://places-backend-wk.herokuapp.com/reviews"
        let parameters: [String: Any] = [
            "place": place,
        ]
        AF.request(endpoint, method: .get, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let reviewData = try? jsonDecoder.decode([Review].self, from: data) {
                    // Instructions: Use completion to handle response
                    completion(reviewData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addFavorite(placeID: Int, completion: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + User.current!.session_token
        ]
        print(User.current!.session_token)
        let endpoint = "https://places-backend-wk.herokuapp.com/users/favorites/\(placeID)"
        AF.request(endpoint, method: .post, encoding: JSONEncoding.default, headers: header).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(4)
                print("added favorite")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func removeFavorite(placeID: Int, completion: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + User.current!.session_token
        ]
        print(User.current!.session_token)
        let endpoint = "https://places-backend-wk.herokuapp.com/users/favorites/\(placeID)"
        AF.request(endpoint, method: .delete, encoding: JSONEncoding.default, headers: header).validate().responseData { response in
            switch response.result {
            case .success(_):
                completion(4)
                print("deleted favorite")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUserReviews(completion: @escaping ([Review]) -> Void) {
        let userID = User.current?.user_id
        print(userID!)
//        let header: HTTPHeaders = [
//            "Authorization": "Bearer " + User.current!.session_token
//        ]
        let endpoint = "\(host)reviews?user=\(userID ?? -1)"
        print(endpoint)
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let reviewData = try? jsonDecoder.decode([Review].self, from: data) {
                    print("this is review")
                    print(reviewData)
                    completion(reviewData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUserFavorites(completion: @escaping ([Place]) -> Void) {
        let userID = User.current?.user_id
        print(userID!)
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + User.current!.session_token
        ]
        let endpoint = "\(host)users/favorites"
        print(endpoint)
        AF.request(endpoint, method: .post, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let favoriteData = try? jsonDecoder.decode([Place].self, from: data) {
                    print("this is favorite")
                    print(favoriteData)
                    completion(favoriteData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllUsers(completion: @escaping ([User]) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer " + User.current!.session_token
        ]
        let endpoint = "\(host)users/all"
        print(endpoint)
        AF.request(endpoint, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let usersData = try? jsonDecoder.decode([User].self, from: data) {
                    print("this is all users")
                    completion(usersData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    for user in allUsers {
//        if (user.user_id == tryingToFindUserID) {
//            username = user.username
//        }
//    }

}
