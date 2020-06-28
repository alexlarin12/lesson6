//
//  VKService.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper
import PromiseKit
protocol ApiServiceInterface {
    typealias Out = Swift.Result
 //   func loadData<T:Decodable>(request:URLRequest) -> Promise<[T]>
    func loadFriendsData(token:String, userId:Int) -> Promise<[ItemsFriend]>
    func loadGroupsData(token:String, userId:Int) -> Promise<[ItemsGroup]>
    func loadPhotosData(token:String, ownerId:Int) -> Promise<[Photo]>
    func loadNewsData(token:String, userId:Int, nextFrom:String?, startTime: Double, completion: @escaping (Out<ItemsNews, Error>) -> Void)
    func loadUserData(token:String, userId:Int, completion: @escaping ([ResponseUser]) -> Void)
    
}
enum RequestError:Error{
    case failedRequest(massage:String)
    case decodableError
    case notFound
    case parsingFailed
}
class ApiService: ApiServiceInterface {
    let useRealmData = FriendsRepositiry()
    var usersRealm = [UserRealm]()
   // typealias Out = Swift.Result
    private let idFromKeychain = KeychainWrapper.standard.integer(forKey: "id")!
    private let tokenFromKeychain = KeychainWrapper.standard.string(forKey: "token")
    
    // Дженерик функция для запроса к серверу:
    func loadData<T:Decodable>(request:URLRequest) -> Promise<[T]> {
        return Promise<[T]> { resolver in
            SessionManager.custom.request(request).responseData{ response in
                switch response.result {
                    case .failure(let error):
                        resolver.reject(error)
                    case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                        resolver.fulfill(result.response.items)
                    } catch {
                        resolver.reject(RequestError.parsingFailed)
                    }
                }
            }
        }
    }
    // список друзей:
    func loadFriendsData(token:String, userId:Int) -> Promise<[ItemsFriend]>{
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        return loadData(request: request)
    }
    
    // список групп:
    func loadGroupsData(token:String, userId:Int) -> Promise<[ItemsGroup]>{
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value:String(userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "site"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        return loadData(request: request)
    }
      // список фото:
    func loadPhotosData(token:String, ownerId:Int) -> Promise<[Photo]>{
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(ownerId)"),
            URLQueryItem(name: "count", value: "12"),
            URLQueryItem(name: "extended", value: "5"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.103")
        ]
        let request = URLRequest(url:urlConstructor.url!)
        return loadData(request: request)
    }
     
    // новости:
    func loadNewsData(token:String, userId:Int, nextFrom:String?, startTime: Double, completion: @escaping (Out<ItemsNews, Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/newsfeed.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "filters", value: "post"),
                URLQueryItem(name: "count", value: "5"),
                URLQueryItem(name: "owner_id", value: "\(userId)"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.103"),
                URLQueryItem(name: "start_from", value: nextFrom ?? ""),
                URLQueryItem(name: "start_time", value: "\(startTime)")
            ]
            let request = URLRequest(url:urlConstructor.url!)
       
            SessionManager.custom.request(request).responseData{
                   response in
                switch response.result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(data):
                    do {
                        let newsResponse = try JSONDecoder().decode(NewsModel.self, from: data)
                        let news = newsResponse.response
                             completion(.success(news))
                    } catch {
                            completion(.failure(error))
                        
                    }
                }
             }
        }
    }
    // инфо о пользователе
    func loadUserData(token:String, userId:Int, completion: @escaping ([ResponseUser]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/users.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "user_id", value: String(userId)),
                URLQueryItem(name: "fields", value: "photo_50"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.103")
            ]
            let request = URLRequest(url:urlConstructor.url!)
            
            SessionManager.custom.request(request).responseData{
                response in
                guard let data = response.value else{return}
                do{
                    let user = try JSONDecoder().decode(UserModel.self, from: data).response
                    completion(user ?? [])
                }catch{
                    print(error)
                }
            }
        }
    }
}
class ApiServiceProxy: ApiServiceInterface {
    typealias Out = Swift.Result
    let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func loadFriendsData(token: String, userId: Int) -> Promise<[ItemsFriend]> {
        print("Called func loadFriendsData")
        return apiService.loadFriendsData(token: token, userId: userId)
        
    }
    
    func loadGroupsData(token: String, userId: Int) -> Promise<[ItemsGroup]> {
        print("Called func loadGroupsData")
        return apiService.loadGroupsData(token: token, userId: userId)
    }
    
    func loadPhotosData(token: String, ownerId: Int) -> Promise<[Photo]> {
        print("Called func loadPhotosData")
        return apiService.loadPhotosData(token: token, ownerId: ownerId)
    }
    
    func loadNewsData(token: String, userId: Int, nextFrom: String?, startTime: Double, completion: @escaping (Out<ItemsNews, Error>) -> Void) {
        self.apiService.loadNewsData(token: token, userId: userId, nextFrom: nextFrom, startTime: startTime, completion: completion)
        print("Called func loadNewsData")
    }
    
    func loadUserData(token: String, userId: Int, completion: @escaping ([ResponseUser]) -> Void) {
        self.apiService.loadUserData(token: token, userId: userId, completion: completion)
        print("Called func loadUserData")
        
    }
    
}
