//
//  DefaultGestureTableViewCell.swift
//  sBlue
//
//  Created by Hunter Leise on 8/4/16.
//  Copyright © 2016 Vivo Applications. All rights reserved.
//

import UIKit

class DefaultGestureTableViewCell: UITableViewCell {
    @IBOutlet weak var defaultGestureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
