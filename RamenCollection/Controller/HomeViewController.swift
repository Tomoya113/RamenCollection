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
            APIClient().request(request, completion: {model in
                print(model!.id)
                UserDefaults.standard.set(String(model!.id), forKey: "id")
            })
        } else {
            print(currentUser!)
        }
        
       
    }


}

