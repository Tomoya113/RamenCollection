//
//  Finish.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/10.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation

struct Finish: Codable {
	var status: String
}

struct FinishRequest: Requestable {
	typealias Model = Finish
    var userId: String
	var shopId: String
    
	init(userId: String, shopId: String) {
        
        self.userId = userId
		self.shopId = shopId
    }
    
    var url: String {
        return "https://ramen-collection-api.herokuapp.com/api/v1/shop_users/finish/\(self.userId)/\(self.shopId)"
    }
    
    var httpMethod: String {
        return "POST"
    }
    
	func decode(from data: Data) throws -> Finish {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Finish.self, from: data)
    }
}

