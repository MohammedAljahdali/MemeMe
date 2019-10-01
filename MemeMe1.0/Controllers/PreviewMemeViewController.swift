//
//  PreviewMemeViewController.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 01/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class PreviewMemeViewController: UIViewController {
    
    var theMeme: Meme!
    
    @IBOutlet weak var memeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        memeView.image = self.theMeme.meme
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
