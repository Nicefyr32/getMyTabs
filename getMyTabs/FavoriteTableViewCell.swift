//
//  FavoriteTableViewCell.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 27/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_tabTitle: UILabel!
    
    @IBOutlet weak var lbl_tabType: UILabel!
    
    @IBOutlet weak var lbl_tabArtist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
