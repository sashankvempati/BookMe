//
//  CardCell.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/12/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardnumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
