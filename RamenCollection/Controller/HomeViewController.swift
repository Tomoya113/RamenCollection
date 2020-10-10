//
//  ViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/04.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
	private let mapView: MKMapView = {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		return mapView
	}()
	
    fileprivate func setupUI() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = UserDefaults.standard.string(forKey: "id")
        if currentUser == nil {
            let request = CreateUserRequest()
            APIClient().request(request, completion: {result in
				switch(result) {
				case let .success(model):
					print(model!.id)
					UserDefaults.standard.set(String(model!.id), forKey: "id")
				case let .failure(error):
					switch error {
					case let .server(status):
						print("Error!! StatusCode: \(status)")
					case .noResponse:
						print("Error!! No Response")
					case let .unknown(e):
						print("Error!! Unknown: \(e)")
					default:
						print("Error!! \(error)")
					}
				}
            })
        } else {
			let request = GetStationRequest(userId: currentUser!)
            APIClient().request(request, completion: {result in
				switch(result) {
				case let .success(model):
					DispatchQueue.main.async {
						let latitude = Double(model!.station.latitude)
						let longitude = Double(model!.station.longitude)
						let location = CLLocationCoordinate2DMake(latitude!, longitude!)
						self.mapView.setCenter(location, animated:true)
						
						var region = self.mapView.region
						region.center = location
						region.span.latitudeDelta = 0.005
						region.span.longitudeDelta = 0.005
						// マップビューに縮尺を設定
						self.mapView.setRegion(region, animated:true)
						let station = MKPointAnnotation()
						
						station.coordinate = location
						station.title = model!.station.name
						self.mapView.addAnnotation(station)
						self.setupUI()
					}
				case let .failure(error):
					switch error {
					case let .server(status):
						print("Error!! StatusCode: \(status)")
					case .noResponse:
						print("Error!! No Response")
					case let .unknown(e):
						print("Error!! Unknown: \(e)")
					default:
						print("Error!! \(error)")
					}
				}
            })
        }
    }


}


private extension MKMapView {
    // ロケーションの中心から東西南北1000メートルの領域を表示。
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
