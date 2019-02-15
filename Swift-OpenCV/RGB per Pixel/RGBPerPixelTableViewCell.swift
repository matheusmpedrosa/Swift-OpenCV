//
//  RGBPerPixelTableViewCell.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/15/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

import UIKit

class RGBPerPixelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblWidth: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblRed: UILabel!
    @IBOutlet weak var lblGreen: UILabel!
    @IBOutlet weak var lblBlue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
