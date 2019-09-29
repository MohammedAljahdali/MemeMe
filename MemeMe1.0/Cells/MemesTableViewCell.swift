//
//  MemesTableViewCell.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 29/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class MemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var memeView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
