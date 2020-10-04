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
        
        let request = TestRequest()
        var hoge: String = ""
        let result = APIClient().request(request, completion: {model in
            print(model!.test)
            return model!
        })
        print(result)
    }


}

