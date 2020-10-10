//
//  ShopResultViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/10.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class ShopResultViewController: UIViewController {
	@IBOutlet var textLabel: UILabel!
	var stationId: String = ""
	var array: GetShops = GetShops(shop: [], shopUserStatus: [])
    override func viewDidLoad() {
        super.viewDidLoad()
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = GetShopsRequest(userId: userId!, stationId: self.stationId)
		APIClient().request(request, completion: {model in
			DispatchQueue.main.async {
				self.array.shop = model!.shop
				self.array.shopUserStatus = model!.shopUserStatus
				
//				self.tableView.reloadData()
			}
		})
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
