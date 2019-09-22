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
    @IBOutlet weak var fillerTopToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var fillerBottomToolbar: UIToolbar!
    
    // MARK: IBActions
    @IBAction func chosePicLibaray(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    @IBAction func chosePicCamera(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    @IBAction func shareMeme(_ sender: Any) {
        let meme = takeMeme()
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.saveMeme()
            }
        }
    }
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldList = [topTextField, bottomTextField]
        for text in textFieldList {
            text.delegate = self
            text.defaultTextAttributes = memeTextAttributes
            text.textAlignment = .center
            text.addTarget(self, action: #selector(ViewController.captalizer(textfield:)), for: UIControl.Event.editingChanged)
        }
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareMeme.isEnabled = false
        
    }
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        cameraPic.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotification()
    }
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeTokeyboardNotification()
        subscribeTokeyboardWillHideNotification()
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
    // MARK: Keyboard
    @objc func captalizer (textfield: UITextField) {
        textfield.text = textfield.text!.uppercased()
    }
    
    // MARK: keyboard Notification
    func getKeybordHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardHeight = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if topTextField.isEditing {
            return
        }
        view.frame.origin.y = -getKeybordHeight(notification)
    }
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func unsubscribeTokeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = (0) as CGFloat
    }
    func subscribeTokeyboardWillHideNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: handling memes
    func hideToolbars(_ value: Bool) {
        topToolbar.isHidden = value
        bottomToolbar.isHidden = value
        fillerTopToolbar.isHidden = value
        fillerBottomToolbar.isHidden = value
    }
    
    func takeMeme () -> UIImage {
        // hide toolbar
        hideToolbars(true)
        // take the image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let meme: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // show toolbar
        hideToolbars(false)
        return meme
    }
    
    func saveMeme () {
        _ = Meme(topText: textFieldList[0].text!, bottomText: textFieldList[1].text!, image: memeImageView.image!, meme: takeMeme())
    }
    
    
    
    


}

