//
//  FinalImageTableViewCell.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 3/4/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

import UIKit

class FinalImageTableViewCell: UITableViewCell {

    @IBOutlet weak var finalImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
