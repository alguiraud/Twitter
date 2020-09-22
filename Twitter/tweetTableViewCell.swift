//
//  tweetTableViewCell.swift
//  Twitter
//
//  Created by Andre Guiraud on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
