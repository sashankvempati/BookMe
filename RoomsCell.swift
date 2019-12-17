//
//  RoomsCell.swift
//  BookMe
//
//  Created by Alejandro pimentel on 5/9/19.
//  Copyright © 2019 Alejandro pimentel. All rights reserved.
//

import UIKit

class RoomsCell: UITableViewCell {

    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    //@IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
