//
//  RBGPerPixelTableViewController.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/15/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

//TO DO:
//aquele navegador lateral direito tipo no app de contatos de deslizar e ir mais rápido ao valor

import UIKit

class RBGPerPixelTableViewController: UITableViewController {
    
    var receivedImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.alwaysBounceVertical = false //desabilita o scroll caso a tableView caiba na tela
        tableView.tableFooterView = UIView() //esconde as separator lines extras depois do ultimo elemento da tableView
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Column #\(section)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Int(SwiftOpenCVWrapper.getImageHeight(receivedImage))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(SwiftOpenCVWrapper.getImageWidth(receivedImage))
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RGBPerPixelTableViewCell

        let w = indexPath.row
        let h = indexPath.section
        cell.lblWidth.text = "row: \(w)"
        cell.lblRed.text = "\(SwiftOpenCVWrapper.getPixelRedValue(Int32(w), Int32(h), receivedImage))"
        cell.lblGreen.text = "\(SwiftOpenCVWrapper.getPixelGreenValue(Int32(w), Int32(h), receivedImage))"
        cell.lblBlue.text = "\(SwiftOpenCVWrapper.getPixelBlueValue(Int32(w), Int32(h), receivedImage))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
