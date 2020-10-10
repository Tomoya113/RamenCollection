//
//  MapViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/05.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let initialLocation = CLLocation(latitude: 34.7031923, longitude: 135.4967068)
//
        let latitude = 34.7031923
        let longitude = 135.4967068
        // 緯度・軽度を設定
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        // マップビューに緯度・軽度を設定
        mapView.setCenter(location, animated:true)

        // 縮尺を設定
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.005
        region.span.longitudeDelta = 0.005
        // マップビューに縮尺を設定
        mapView.setRegion(region, animated:true)
        
        let station = MKPointAnnotation()
        
        station.coordinate = location
        station.title = "梅田駅"
        mapView.addAnnotation(station)
        
//        let shop = Shop(title: "煮干しラーメン玉五郎 阪急三番街店", coordinate: CLLocationCoordinate2D(latitude: 34.7045383, longitude: 135.4973547))
//        mapView.addAnnotation(shop)
        mapView.register(
        ShopMarkerView.self,
        forAnnotationViewWithReuseIdentifier:
          MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

