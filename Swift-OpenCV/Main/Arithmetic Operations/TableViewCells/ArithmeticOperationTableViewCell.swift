//
//  ArithmeticOperationTableViewCell.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 3/4/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

import UIKit

class ArithmeticOperationTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControlOperation: UISegmentedControl!
    var valueChangedClosure : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectedOperationChanged(_ sender: Any) {
        self.valueChangedClosure?()
    }
}
