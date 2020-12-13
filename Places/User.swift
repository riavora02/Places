//
//  User.swift
//  Places
//
//  Created by Neil Madhavani on 12/12/20.
//

// TODO: Define model for our restaurant resposne
struct UsersDataResponse: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your RestaurantsDataResponse object after the JSON response.
     */
    var user: [User]
}


// TODO: Define model for our restaurant
struct User: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your Restaurant object after the JSON response, except using camel
     * case instead of snake case, as shown in our JSON response.
     * Helpful Hint: We have two different possible restaurant objects we might get
     * back from the backend, one with "reviews" and one without. How do we include
     * this in our model despite this being the case? Think about what we do when
     * a value is allowed to be nil...
     */
    var user_id: Int
    var username: String
    var session_token: String
    var session_expiration: String
    var update_token: String
}
