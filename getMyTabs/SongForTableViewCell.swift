//
//  songForTableViewCell.swift
//  getMyTabs
//
//  Created by Thomas Rasmussen on 26/04/2016.
//  Copyright © 2016 Thomas Rasmussen. All rights reserved.
//

import UIKit

class SongForTableViewCell: UITableViewCell {


    @IBOutlet weak var lbl_tabType: UILabel!
    
    @IBOutlet weak var lbl_tabArtist: UILabel!
    
    @IBOutlet weak var lbl_tabTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
