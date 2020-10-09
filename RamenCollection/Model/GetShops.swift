//
//  GetShops.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/09.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation

struct GetShops: Codable {
	var shop: [ShopName]
	var shopUserStatus: [ShopUserStatus]
}


struct ShopName: Codable {
	var name: String
}

struct ShopUserStatus: Codable {	
	var id: Int
	var isFinished: Bool
}


struct GetShopsRequest: Requestable {
	
	typealias Model = GetShops
    var userId: String
	var stationId: String
    
	init(userId: String, stationId: String) {
        
		self.userId = userId;
		self.stationId = stationId;
    }
    
    var url: String {
		return "https://ramen-collection-api.herokuapp.com/api/v1/users/get_shops/\(self.stationId)/\(self.userId)"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
//    func decode(from data: Data) throws -> GetShops{
//		var array: GetShops = GetShops(shop: [], shopUserStatus: [])
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//		print(data)
//		do {
//			let decoded = try decoder.decode(GetShops.self, from: data)
//		} catch let error {
//			print("Error = \(error)")
//		}
//        return array
//    }
	
    func decode(from data: Data) throws -> GetShops {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GetShops.self, from: data)
    }
}


