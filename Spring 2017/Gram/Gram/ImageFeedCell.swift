//
//  ImageFeedCell.swift
//  Gram
//
//  Created by Kode Williams on 3/14/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import ParseUI

class ImageFeedCell: UITableViewCell {

    
    @IBOutlet var postImageView: PFImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
