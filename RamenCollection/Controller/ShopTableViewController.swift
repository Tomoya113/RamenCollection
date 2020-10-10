//
//  ShopTableViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/07.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class ShopTableViewController: UITableViewController {
	var stationId: String = ""
	var array: GetShops = GetShops(shop: [], shopUserStatus: [])
	override func viewDidLoad() {
		super.viewDidLoad()
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = GetShopsRequest(userId: userId!, stationId: self.stationId)
		APIClient().request(request, completion: {result in
			switch(result) {
			case let .success(model):
				DispatchQueue.main.async {
					self.array.shop = model!.shop
					self.array.shopUserStatus = model!.shopUserStatus
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
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return array.shop.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//		print(array.shop[indexPath.row])
//		print(array.shopUserStatus)
		cell.textLabel!.text = array.shop[indexPath.row].name
		cell.tag = array.shopUserStatus[indexPath.row].id
		let stationImage: UIImage;
		if array.shopUserStatus[indexPath.row].isFinished {
			stationImage = UIImage(named: "OrangeStation.png")!
		} else {
			stationImage = UIImage(named: "BlueStation.png")!
		}
		cell.imageView!.image = stationImage.resize(size: CGSize(width: 50, height: 50))
		return cell
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
//		// タップされたセルの行番号を出力
//		let cell: UITableViewCell = self.tableView(tableView, cellForRowAt: indexPath)
//		let userId = UserDefaults.standard.string(forKey: "id")
//		let request = RegisterStationRequest(userId: String(userId!), stationId: String(cell.tag))
//		APIClient().request(request, completion: {model in
//			DispatchQueue.main.async {
//				self.navigationController?.popViewController(animated: true)
//			}
//		})
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.separatorInset = .zero
	}
	
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // シェアのアクションを設定する
        let doneAction = UIContextualAction(style: .normal  , title: "完食") {
            (ctxAction, view, completionHandler) in
			let userId = UserDefaults.standard.string(forKey: "id")!
			let shopId = self.array.shopUserStatus[indexPath.row].shopId
			self.array.shopUserStatus[indexPath.row].isFinished.toggle()
			let request = FinishRequest(userId: userId, shopId: shopId)
			APIClient().request(request, completion: {model in
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			})
            completionHandler(true)
        }
        // シェアボタンのデザインを設定する
//        let doneImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(UIColor.white, renderingMode: .alwaysTemplate)
//        doneAction.image = doneImage
        doneAction.backgroundColor = UIColor(red: 249/255, green: 171/255, blue: 24/255, alpha: 1.0)

        // スワイプでの削除を無効化して設定する
        let swipeAction = UISwipeActionsConfiguration(actions:[doneAction])
        swipeAction.performsFirstActionWithFullSwipe = false
       
        return swipeAction

    }

	/*
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

		// Configure the cell...

		return cell
	}
	*/

	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
	}
*/

}
