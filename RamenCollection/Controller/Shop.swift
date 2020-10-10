//
//  Shop.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/05.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Shop: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
	let isFinished: Bool
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D,
		isFinished: Bool
    ) {
        self.title = title
        self.coordinate = coordinate
		self.isFinished = isFinished
        
        super.init()
    }
	
	var markerTintColor: UIColor {
		switch isFinished {
		case true:
			return UIColor(red: 249/255, green: 171/255, blue: 24/255, alpha: 1.0)
		
		case false:
			return UIColor(red: 0/255, green: 105/255, blue: 207/255, alpha: 1.0)
		default:
			return .green
		}
	}
	
	var mapItem: MKMapItem? {
	  guard let title = title else {
		return nil
	  }
	  
	  let addressDict = [CNPostalAddressStreetKey: title]
	  // 位置情報を座標を用いて算出
	  let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
	  // Mapsとの通信に必要なやつ
	  let mapItem = MKMapItem(placemark: placemark)
	  mapItem.name = title
	  return mapItem
	}
    
}
