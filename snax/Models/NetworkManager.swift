//
//  NetworkManager.swift
//  L7
//
//  Created by Mindy Lou on 4/11/18.
//  Copyright © 2018 Mindy Lou. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let restaurantEndpoint = "http://35.236.231.84/api/snax/restaurants/"
    private static let createUserEndpoint = "http://35.236.231.84/api/snax/users/"
    
    //RestaurantMenuItemDataReponse is a list of menu items
    //Gets the list of menu items for the restaurant named name
    static func getRestaurantMenuItems(name: String, completion: @escaping ([MenuItem]) -> Void) {
        let newname = name.replacingOccurrences(of: " ", with: "%20")
        Alamofire.request("http://35.236.231.84/api/snax/restaurant/\(newname)/food/", method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let restaurantMenuItemResponse = try? jsonDecoder.decode(RestaurantMenuItemResponse.self, from: data) {
                    let menu = restaurantMenuItemResponse.data
                    completion(menu)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    static func createOrderPost(food: MenuItem, idToken: String, name: String, givenName: String, familyName: String, email: String, completion: @escaping (User) -> Void) {
//        let parameters: [String: Any] = [
//            "userId": userID,
//            "idToken": idToken,
//            "fullName": name,
//            "givenName": givenName,
//            "familyName": familyName,
//            "email": email
//        ]
//        Alamofire.request(createUserEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let jsonDecoder = JSONDecoder()
//                if let user = try? jsonDecoder.decode(User.self, from: data) {
//                    completion(user)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    static func createUserPost(name: String, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "name": name
        ]
        Alamofire.request(createUserEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseData
            { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(CreateUserResponse.self, from: data) {
                    let user = response.data
                    completion(user)
                    print("received user with id \(user.id)")
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    //Send post request when order is placed.
//    static func sendOrder(user id: Int, completion: @escaping (User) -> Void) {
//        Alamofire.request("http://35.236.231.84/api/snax/placeorder/", method: .post).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let jsonDecoder = JSONDecoder()
//                if let placeOrderResponse = try? jsonDecoder.decode(RestaurantMenuItemResponse.self, from: data) {
//                    let menu = restaurantMenuItemResponse.data
//                    completion(menu)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    
    static func loginPost(userID: String, idToken: String, name: String, givenName: String, familyName: String, email: String, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "userId": userID,
            "idToken": idToken,
            "fullName": name,
            "givenName": givenName,
            "familyName": familyName,
            "email": email
        ]
        Alamofire.request(createUserEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let user = try? jsonDecoder.decode(User.self, from: data) {
                    completion(user)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    static func loginGet(idToken: String, completion: @escaping ([User]) -> Void) {
//        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let jsonDecoder = JSONDecoder()
//                if let user = try? jsonDecoder.decode(UserResponse.self, from: data) {
//                    completion(user.data.users)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
}
