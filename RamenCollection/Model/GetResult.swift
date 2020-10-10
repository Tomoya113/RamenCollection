//
//  GetResult.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/10.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation

struct GetResult: Codable {
	var shop: [ShopName]
	var shopUserStatus: [ShopUserStatus]
	var shopCount: Int
	var finished: Int
}


struct GetResultRequest: Requestable {
	
	typealias Model = GetResult
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
	
    func decode(from data: Data) throws -> GetResult {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GetResult.self, from: data)
    }
}


