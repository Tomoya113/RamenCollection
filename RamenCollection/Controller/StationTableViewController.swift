//
//  ListTableViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/07.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController {
	var array: [UserStations] = []
	var stationId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = UserStationsRequest(userId: userId!)
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

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
		self.stationId = String(array[indexPath.row].id)
		performSegue(withIdentifier: "toShopTableViewController", sender: nil)
	}
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.separatorInset = .zero
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
		if (segue.identifier == "toShopTableViewController") {
			let nextVC: ShopTableViewController = (segue.destination as? ShopTableViewController)!
			nextVC.stationId = self.stationId
		}
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
