//
//  CustomTabBar.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/04.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE: SwiftのUIcolorのRGB値は、256段階ではなく、0~1.0までの値で指定するようになっている
        self.tabBar.tintColor = UIColor(red: 249/255, green: 171/255, blue: 24/255, alpha: 1.0)
    }
}
