//
//  Shop.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/05.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation
import MapKit

class Shop: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
}
