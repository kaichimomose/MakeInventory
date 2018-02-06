//
//  inventoriesTableViewCell.swift
//  MakeInventory
//
//  Created by Kaichi Momose on 2018/02/06.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class inventoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
