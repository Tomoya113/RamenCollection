//
//  PrizeCollectionViewCell.swift
//  RamenCollection
//
//  Created by tomoya tanaka on 2020/10/07.
//  Copyright © 2020 Tomoya Tanaka. All rights reserved.
//

import UIKit

class PrizeCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
		
    }
	required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // cellの枠の太さ
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = UIColor.black.cgColor
        // cellを丸くする
        self.layer.cornerRadius = 8.0
    }

}
