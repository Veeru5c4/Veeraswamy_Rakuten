//
//  ConnectTableViewCell.swift
//  Veeraswamy_Rakuten
//
//  Created by Veeraswamy on 21/09/20.
//  Copyright © 2020 Orbcomm. All rights reserved.
//

import UIKit

class ConnectTableViewCell: UITableViewCell {

    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
