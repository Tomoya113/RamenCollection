//
//  GetResult.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/10.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation

struct GetStation: Codable {
	var shops: [ShopInformation]
	var shopUserStatus: [ShopUserStatus]
	var station: Station
}

struct Station: Codable {
	var name: String
	var latitude: String
	var longitude: String
}

struct ShopInformation: Codable {
	var name: String
	var latitude: String
	var longitude: String
}


struct GetStationRequest: Requestable {
	
	typealias Model = GetStation
    var userId: String
    
	init(userId: String) {
		self.userId = userId;
    }
    
    var url: String {
		return "https://ramen-collection-api.herokuapp.com/api/v1/users/get_station/\(self.userId)"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
	
    func decode(from data: Data) throws -> GetStation {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GetStation.self, from: data)
    }
}


