//
//  ShopResultViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/10.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class ShopResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet var textLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	var stationId: String = ""
	var array: GetResult = GetResult(shop: [], shopUserStatus: [], shopCount: 0, finished: 0)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = GetResultRequest(userId: userId!, stationId: self.stationId)
		APIClient().request(request, completion: {result in
			switch(result) {
			case let .success(model):
				DispatchQueue.main.async {
					self.array.shop = model!.shop
					self.array.shopUserStatus = model!.shopUserStatus
					self.array.shopCount = model!.shopCount
					self.array.finished = model!.finished
					let result: Double = round(Double(self.array.finished) / Double(self.array.shopCount) * 100 * 10) / 10
					self.textLabel.text = "達成率：\(result)%"
					print(Double(self.array.finished / self.array.shopCount))
					self.tableView.reloadData()
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return array.shop.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = array.shop[indexPath.row].name
		var image: UIImage!
		if array.shopUserStatus[indexPath.row].isFinished {
			image = UIImage(named: "OrangeStation.png")
		} else {
			image = UIImage(named: "BlueStation.png")
		}
		cell.imageView?.image = image
		return cell
	}

}
