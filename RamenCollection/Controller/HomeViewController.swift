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
	var shops: [ShopInformation] = []
	var station: Station!
	var shopAnnotations: [Shop] = []
	fileprivate func setupUI() {
		view.addSubview(mapView)
		mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		let latitude = Double(self.station.latitude)
		let longitude = Double(self.station.longitude)
		let location = CLLocationCoordinate2DMake(latitude!, longitude!)
		mapView.setCenter(location, animated:true)
		var region = mapView.region
		region.center = location
		region.span.latitudeDelta = 0.005
		region.span.longitudeDelta = 0.005
		// マップビューに縮尺を設定
		mapView.setRegion(region, animated:true)
		let station = MKPointAnnotation()
		station.coordinate = location
		station.title = self.station.name
		mapView.addAnnotation(station)
		for shop in self.shops {
			let latitude = Double(shop.latitude)
			let longitude = Double(shop.longitude)
			let location = CLLocationCoordinate2DMake(latitude!, longitude!)
			let shopAnnotation = Shop.init(title: shop.name, coordinate: location)
			//							self.shopAnnotations.append(shopAnnotation)
			mapView.addAnnotation(shopAnnotation)
		}
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
						self.shops = model!.shops
						self.station = model!.station
						self.setupUI()
					}
					
					self.mapView.register(
						ShopMarkerView.self,
						forAnnotationViewWithReuseIdentifier:
						MKMapViewDefaultAnnotationViewReuseIdentifier)
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
