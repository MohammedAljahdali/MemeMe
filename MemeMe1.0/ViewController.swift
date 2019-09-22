//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 20/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    struct Meme {
        let topText: String
        let bottomText: String
        let image: UIImage
        let meme: UIImage
    }
    var textFieldList: [UITextField] = []
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  4.0
    ]
    
    // MARK: IBOutlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var addPicLibaray: UIBarButtonItem!
    @IBOutlet weak var cameraPic: UIBarButtonItem!
    @IBOutlet weak var shareMeme: UIBarButtonItem!
    
    // MARK: IBActions
    @IBAction func chosePicLibaray(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldList = [topTextField, bottomTextField]
        for text in textFieldList {
            text.defaultTextAttributes = memeTextAttributes
            text.textAlignment = .center
        }
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
    }
    
    // MARK: ImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImageView.image = pickedImage
            memeImageView.contentMode = .scaleToFill
            shareMeme.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    // MARk: TextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARk: Keyboard
    func captalizer () {
        
    }
    
    
    


}

