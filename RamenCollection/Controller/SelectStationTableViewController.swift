//
//  SelectStationTableViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/05.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class SelectStationTableViewController: UITableViewController {
	var array: [Stations] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		//        let request = GetStationsRequest()
		
		//        let group = DispatchGroup()
		//        let queue = DispatchQueue(label: "queue")
		//        group.enter()
		//        queue.async(group: group) {
		//            APIClient().request(request, completion: {model in
		//                model!.forEach { station in
		//                    self.array.append(station.name)
		//                }
		//                group.leave()
		//            })
		//        }
		//
		//        group.notify(queue: DispatchQueue.main) { [weak self] in
		//            self!.tableView.reloadData()
		//        }
		
		
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		
		self.setup()
	}
	
	func setup() -> Void {
		let request = GetStationsRequest()
		APIClient().request(request, completion: {result in
			switch(result) {
			case let .success(model):
				DispatchQueue.main.async {
					self.array = model!
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
	
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return array.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel!.text = array[indexPath.row].name
		cell.tag = array[indexPath.row].id
		let stationImage = UIImage(named: "OrangeStation.png")!
		cell.imageView!.image = stationImage.resize(size: CGSize(width: 50, height: 50))
		return cell
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// タップされたセルの行番号を出力
		let cell: UITableViewCell = self.tableView(tableView, cellForRowAt: indexPath)
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = RegisterStationRequest(userId: String(userId!), stationId: String(cell.tag))
		APIClient().request(request, completion: {model in
			DispatchQueue.main.async {
				self.navigationController?.popViewController(animated: true)
			}
		})
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.separatorInset = .zero
	}
	
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

extension UIImage {
	
	func resize(size: CGSize) -> UIImage {
		let widthRatio = size.width / self.size.width
		let heightRatio = size.height / self.size.height
		let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
		let resizedSize = CGSize(width: (self.size.width * ratio), height: (self.size.height * ratio))
		// 画質を落とさないように以下を修正
		UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
		draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return resizedImage!
	}
}
