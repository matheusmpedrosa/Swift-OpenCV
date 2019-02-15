//
//  ViewController.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 2/14/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

//TO DO:
//criar outlet pra viewMore
//animação de esconder/mostrar a viewMore com constraint e tals
//dismiss da viewMore ao clicar fora pra view ou outra coisa



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnMoreView: UIBarButtonItem!
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnLibrary: UIBarButtonItem!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblImageResolution: UILabel!
    @IBOutlet weak var lblNumberOfPixels: UILabel!
    @IBOutlet weak var btnMatrixOfQuantifiedValues: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(SwiftOpenCVWrapper.openCVVersionString())
        
        lblImageResolution.isHidden = true
        lblImageResolution.text = ""
        lblNumberOfPixels.isHidden = true
        lblNumberOfPixels.text = ""
    }
    
    @IBAction func toggleShowMoreView(_ sender: Any) {
        if lblImageResolution.isHidden { //toggle labels
            lblImageResolution.isHidden = false
            lblNumberOfPixels.isHidden = false
            if image.image != nil { //get resolution if available
                let w = SwiftOpenCVWrapper.getImageWidth(image.image!)
                let h = SwiftOpenCVWrapper.getImageHeight(image.image!)
                let p = w * h
                lblImageResolution.text = "\(w) x \(h)"
                lblNumberOfPixels.text = "\(p) pixels"
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
            lblImageResolution.isHidden = true
            lblNumberOfPixels.isHidden = true
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
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = imagePicked
        dismiss(animated: true, completion: nil)
        lblImageResolution.isHidden = true
    }
}
