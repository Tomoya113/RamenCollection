//
//  ViewController.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/04.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
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
            print(currentUser!)
        }
        
       
    }


}

