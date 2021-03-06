//
//  PrizeCollectionViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/07.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class PrizeCollectionViewController: UICollectionViewController {
	var array: [UserStations] = []
	var stationId: String = ""
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
		self.collectionView.register(UINib(nibName: "PrizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		layout.itemSize = CGSize(width: 100, height: 100)
		self.collectionView.collectionViewLayout = layout
		let userId = UserDefaults.standard.string(forKey: "id")
		let request = UserStationsRequest(userId: userId!)
		APIClient().request(request, completion: {result in
			switch(result) {
			case let .success(model):
				DispatchQueue.main.async {
					self.array = model!
					self.collectionView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
		return array.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PrizeCollectionViewCell
		
		cell.textLabel.text = array[indexPath.row].name
		cell.image.image = UIImage(named: "OrangeStation.png")!
        return cell
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.stationId = String(array[indexPath.row].id)
		performSegue(withIdentifier: "toShopResultViewController", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
		if (segue.identifier == "toShopResultViewController") {
			let nextVC: ShopResultViewController = (segue.destination as? ShopResultViewController)!
			nextVC.stationId = self.stationId
		}
	}
	
//	   override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//		   if (segue.identifier == "toShopTableController") {
//			   let subVC: ShopResultTableViewController = (segue.destination as? ShopResultTableViewController)!
//	
//			   // SubViewController のselectedImgに選択された画像を設定する
////			   subVC.selectedImg = selectedImage
//		   }
//	   }
	
	
//    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let horizontalSpace : CGFloat = 10
////        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
//		let cellSize : CGFloat = 100
//        return CGSize(width: cellSize, height: cellSize)
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
