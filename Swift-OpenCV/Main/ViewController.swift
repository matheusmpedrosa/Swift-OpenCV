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
    
    var viewMoreIsHidden = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Main"
        
        print(SwiftOpenCVWrapper.openCVVersionString())
        
        viewMoreIsHidden = true
        lblImageResolution.text = ""
        lblNumberOfPixels.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if image.image != nil {
            if segue.identifier == "segueToMatrixView" {
                if let destination = segue.destination as? RBGPerPixelTableViewController {
                    destination.receivedImage = image.image!
                }
            }
        }
    }
    
    @IBAction func toggleShowMoreView(_ sender: Any) {
        if viewMoreIsHidden { //toggle labels
            if image.image != nil { //get resolution if available
                let w = SwiftOpenCVWrapper.getImageWidth(image.image!)
                let h = SwiftOpenCVWrapper.getImageHeight(image.image!)
                let p = w * h
                lblImageResolution.text = "\(w) x \(h)"
                lblNumberOfPixels.text = "\(p) pixels"
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.constraintBottomViewMore.constant = 0
                    self.viewMoreIsHidden = false
                    self.view.layoutIfNeeded()
                }, completion: nil)
            } else {
                // create the alert
                let alert = UIAlertController(title: "Wait!", message: "First you need to select an image.", preferredStyle: UIAlertController.Style.alert)
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { action in
                    self.openCamera((Any).self)
                }))
                alert.addAction(UIAlertAction(title: "Open Photo Library", style: .default, handler: { action in
                    self.openLibrary((Any).self)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.constraintBottomViewMore.constant = -300
                self.viewMoreIsHidden = true
                self.view.layoutIfNeeded()
            }, completion: nil)
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
        if w >= 500 || h >= 500 {
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
        dismiss(animated: true, completion: nil)
        viewMoreIsHidden = true
    }
}
