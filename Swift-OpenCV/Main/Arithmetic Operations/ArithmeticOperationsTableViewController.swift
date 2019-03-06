//
//  ArithmeticOperationsTableViewController.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 3/4/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

import UIKit

class ArithmeticOperationsTableViewController: UITableViewController {
    
    var receivedImage = UIImage()
    let sectionsHeader = ["First Image","Arithmetic Operation","Second Image","","Final Image"]
    let sectionsFooter = ["Tap the image to select a new one.","Choose an arithmetic operation.","Tap the image to select a new one.","",""]
    
    var imageCell = 1   //1 : FirstImageTableViewCell
                        //2 : SecondImageTalbeViewCell
    
    var firstImage : UIImage!
    var secondImage : UIImage!
    var segmentedControlerOperationIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Arithmetic Operations"
    }
    
    func pickImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeader.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstImageCell", for: indexPath) as! FirstImageTableViewCell
            cell.firstImage.image = receivedImage
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "arithmeticOperationCell", for: indexPath) as! ArithmeticOperationTableViewCell
            cell.valueChangedClosure = { [weak self] in
                self!.segmentedControlerOperationIndex = cell.segmentedControlOperation.selectedSegmentIndex
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondImageCell", for: indexPath) as! SecondImageTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "runArithmeticOperationCell", for: indexPath) as! RunArithmeticOperationTableViewCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "finalImageCell", for: indexPath) as! FinalImageTableViewCell
            cell.isUserInteractionEnabled = false
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            self.pickImage()
            imageCell = 1
        case 2:
            self.pickImage()
            imageCell = 2
        case 3:
            print("Run arithmetic operation: \(segmentedControlerOperationIndex)")
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.0
        case 2:
            return 100.0
        case 4:
            return 300
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionsFooter[section]
    }

}

extension ArithmeticOperationsTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if imageCell == 1 {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstImageTableViewCell
            cell.firstImage.image = imagePicked
        } else if imageCell == 2 {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! SecondImageTableViewCell
            cell.secondImage.image = imagePicked
        }
        dismiss(animated: true, completion: nil)
    }
}
