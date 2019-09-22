//
//  MemeUIImagePickerDelegate.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 20/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation
import UIKit

class MemeUIImagePickerDelegate: NSObject, UIImagePickerControllerDelegate {
    
    let shareMeme: UIBarButtonItem
    let memeImageView: UIImageView
    
    init(shareMeme: UIBarButtonItem, memeImageView: UIImageView) {
        self.shareMeme = shareMeme
        self.memeImageView = memeImageView
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImageView.image = pickedImage
            memeImageView.contentMode = .scaleAspectFit
            shareMeme.isEnabled = true
            
        }
    }
}
