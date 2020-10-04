//
//  ShopViews.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/05.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import Foundation
import MapKit

class ShopMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
       willSet {
         // 1
         guard let shop = newValue as? Shop else {
           return
         }
         canShowCallout = true
         calloutOffset = CGPoint(x: -5, y: 5)
         rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    

         // 2
//         markerTintColor = artwork.markerTintColor
//         if let letter = artwork.discipline?.first {
//           glyphText = String(letter)
//         }
//        glyphText = "test"
       }
     }
}

class ShopView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let shop = newValue as? Shop else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//      let detailLabel = UILabel()
//      detailLabel.numberOfLines = 0
//      detailLabel.font = detailLabel.font.withSize(12)
//      detailLabel.text = shop.subtitle
//      detailCalloutAccessoryView = detailLabel
        
//      image = artwork.image
    }
  }
}
