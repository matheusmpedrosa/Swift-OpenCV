//
//  UIViewControllerUtils.swift
//  Swift-OpenCV
//
//  Created by Matheus Pedrosa on 3/4/19.
//  Copyright © 2019 Matheus Pedrosa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithOptions(title: String?, message: String?, style: UIAlertController.Style, options: String..., completion: @escaping (Int) -> Void) {
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: style)
        
        for (index, option) in options.enumerated() {
            
            let action = UIAlertAction(title: option, style: .default, handler: { (action) in
                completion(index)
            })
            
            let image = UIImage(named: options[index].lowercased())
            let imageView = UIImageView()
            imageView.image = image
            imageView.frame = CGRect(x: 25, y: 18, width: 24, height: 24)
            
            if options[index] == "Cancel" {
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            } else {
                action.setValue(imageView.image, forKey: "image")
                alertController.addAction(action)
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}
