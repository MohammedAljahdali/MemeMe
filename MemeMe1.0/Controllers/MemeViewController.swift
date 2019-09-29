//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 20/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    var textFieldList: [UITextField] = []
//    let memeTextAttributes: [NSAttributedString.Key: Any] = [
//        NSAttributedString.Key.strokeColor: UIColor.black,
//        NSAttributedString.Key.foregroundColor: UIColor.white,
//        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
//        NSAttributedString.Key.strokeWidth:  -1.0
//    ]
    var memeTextAttributes: [NSAttributedString.Key: Any] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let attribute = appDelegate.memeTextAttributes
        return attribute
    }()
    
    
    // MARK: IBOutlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var addPicLibaray: UIBarButtonItem!
    @IBOutlet weak var cameraPic: UIBarButtonItem!
    @IBOutlet weak var shareMeme: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!

    
    // MARK: IBActions
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        var source: UIImagePickerController.SourceType!
        switch sender.tag {
        case 0:
            source = .camera
        case 1:
            source = .photoLibrary
        default:
            source = nil
        }
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source!
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func shareMeme(_ sender: Any) {
        let meme = takeMeme()
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true{
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
            text.addTarget(self, action: #selector(MemeViewController.captalizer(textfield:)), for: UIControl.Event.editingChanged)
        }
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareMeme.isEnabled = false
        
    }
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        cameraPic.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardWillShow()
    }
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeTokeyboardNotification()
        subscribeToKeyboardWillHide()
    }
    
    // MARK: ImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImageView.image = pickedImage
            memeImageView.contentMode = .scaleAspectFit
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
        subscribeToKeyboardWillHide()
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
    
    func subscribeToKeyboardWillShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHide() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeTokeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = (0 as CGFloat)
    }
    
    
    // MARK: handling memes
    func hideToolbars(_ value: Bool) {
        topToolbar.isHidden = value
        bottomToolbar.isHidden = value

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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let meme = Meme(topText: textFieldList[0].text!, bottomText: textFieldList[1].text!, image: memeImageView.image!, meme: takeMeme())
        appDelegate.memes.append(meme)
    }
    
    
    
    


}

