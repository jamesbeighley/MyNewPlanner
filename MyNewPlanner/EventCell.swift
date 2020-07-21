//
//  EventCell.swift
//  MyNewPlanner
//
//  Created by JamesBeighley on 7/21/20.
//  Copyright © 2020 james beighley. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UIView!
    @IBOutlet weak var descriptionlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
