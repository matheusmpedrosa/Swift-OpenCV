//
//  ViewController.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/14/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

//TO DO:
//dismiss da viewMore ao clicar fora pra view ou outra coisa

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnMoreView: UIBarButtonItem!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnLibrary: UIBarButtonItem!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewMore: UIView!
    @IBOutlet weak var lblImageResolution: UILabel!
    @IBOutlet weak var lblNumberOfPixels: UILabel!
    @IBOutlet weak var btnMatrixOfQuantifiedValues: UIButton!
    @IBOutlet weak var constraintBottomViewMore: NSLayoutConstraint!
    
    var imageResolutionViewIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SwiftOpenCVWrapper.openCVVersionString())
        
        if image.image != nil {
            getImageSize()
        } else {
            viewMore.isHidden = true
            lblImageResolution.text = ""
            lblNumberOfPixels.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if image.image != nil {
            switch segue.identifier {
            case "segueToMatrixView":
                if let destination = segue.destination as? RBGPerPixelTableViewController {
                    destination.receivedImage = image.image!
                }
            case "segueToArithmeticView":
                if let destination = segue.destination as? ArithmeticOperationsTableViewController {
                    destination.receivedImage = image.image!
                }
            default:
                break
            }
        }
    }
    
    fileprivate func getImageSize() {
        //get image size if available
        let w = SwiftOpenCVWrapper.getImageWidth(image.image!)
        let h = SwiftOpenCVWrapper.getImageHeight(image.image!)
        let p = w * h
        lblImageResolution.text = "\(w) x \(h)"
        lblNumberOfPixels.text = "\(p) pixels"
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.viewMore.isHidden = false
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func toggleShowMoreView(_ sender: Any) {
        if image.image == nil {
            presentAlertWithOptions(title: "Wait!", message: "First you need to select an image", style: .alert, options: "Open Camera", "Open Photo Library", "Cancel") { (option) in
                switch option {
                case 0:
                    self.openCamera((Any).self)
                case 1:
                    self.openLibrary((Any).self)
                default:
                    break
                }
            }
        } else {
            presentAlertWithOptions(title: "Choose what to do with this image", message: nil, style: .actionSheet, options: "Matrix of Quantified Values", "Arithmetic Operations", "Cancel") { (option) in
                switch option {
                case 0:
                    self.performSegue(withIdentifier: "segueToMatrixView", sender: nil)
                case 1:
                    self.performSegue(withIdentifier: "segueToArithmeticView", sender: nil)
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func openCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func displayMatrixView(_ sender: Any) {
        let w = SwiftOpenCVWrapper.getImageWidth(image.image!)
        let h = SwiftOpenCVWrapper.getImageHeight(image.image!)
        if w >= 150 || h >= 150 {
            let alert = UIAlertController(title: "Be careful!", message: "The image size seems to be too big.\nIt will take some time to processe the matrix information.", preferredStyle: UIAlertController.Style.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "I don't care!", style: .destructive, handler: { action in
                self.performSegue(withIdentifier: "segueToMatrixView", sender: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = imagePicked
        getImageSize()
        viewMore.isHidden = false
        dismiss(animated: true, completion: nil)
    }
}
