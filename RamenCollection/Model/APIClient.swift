//
//  APIClient.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/04.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation
class APIClient {
    func request<T: Requestable>(_ requestable: T, completion: @escaping(T.Model?) -> Void) {
        guard let request = requestable.urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }

            if response.statusCode == 200 {
                let model = try? requestable.decode(from: data)
                completion(model)
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
            }
        })
        task.resume()
    }
    
}


protocol Requestable {
    associatedtype Model
    var url: String { get }
    var httpMethod: String { get }
    func decode(from data: Data) throws -> Model
}

extension Requestable {
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
}

struct Test: Codable {
    var test: String
}

struct TestRequest: Requestable {
    typealias Model = Test
    
    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/test"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    func decode(from data: Data) throws -> Test {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Test.self, from: data)
    }
}

struct CreateUser: Codable {
    var id: Int
}

struct CreateUserRequest: Requestable {
    
    typealias Model = CreateUser
    
    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/users/new"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    func decode(from data: Data) throws -> CreateUser {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(CreateUser.self, from: data)
    }
}

struct Stations: Codable {
    var name: String
    var id: Int
}

struct GetStationsRequest: Requestable {
    
    typealias Model = [Stations]

    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/stations/get_all"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    func decode(from data: Data) throws -> [Stations] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Stations].self, from: data)
    }
}



struct RegisterStation: Codable {
    var status: String
}

struct RegisterStationRequest: Requestable {
    typealias Model = [RegisterStation]
    var userId: String
    var stationId: String
    
    init(userId: String, stationId: String) {
        
        self.userId = userId
        self.stationId = stationId
    }
    
    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/station_users/register/\(self.userId)/\(self.stationId)"
    }
    
    var httpMethod: String {
        return "POST"
    }
    
    func decode(from data: Data) throws -> [RegisterStation] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([RegisterStation].self, from: data)
    }
}

struct UserStations: Codable {
	var name: String
	var id: Int
}

struct UserStationsRequest: Requestable {
	typealias Model = [UserStations]
    var userId: String
    
    init(userId: String) {
        
        self.userId = userId
    }
    
    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/users/get_stations/\(self.userId)"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    func decode(from data: Data) throws -> [UserStations] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([UserStations].self, from: data)
    }
}

