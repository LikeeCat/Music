//
//  ListTableViewCell.swift
//  hello music
//
//  Created by 樊树康 on 16/7/25.
//  Copyright © 2016年 樊树康. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var musicName: UILabel!

    @IBOutlet weak var artist: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
