//
//  PictureCell.swift
//  TheGram
//
//  Created by Chanel Johnson on 6/27/17.
//  Copyright © 2017 Chanel Johnson. All rights reserved.
//

import UIKit

class PictureCell: UITableViewCell {

    @IBOutlet weak var captionUploadLabel: UILabel!
    @IBOutlet weak var postView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
