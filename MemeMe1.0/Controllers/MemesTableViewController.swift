//
//  MemesTableViewController.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 28/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class MemesTableViewController: UITableViewController {
    
    var memes: [Meme] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let meme = appDelegate.memes
        return meme
    }()
    var memeTextAttributes: [NSAttributedString.Key: Any] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var attribute = appDelegate.memeTextAttributes
        attribute[NSAttributedString.Key.font] = UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)
        return attribute
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addMeme))
        navigationItem.title = "Sent Memes Table"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = updateMemes()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemesTableViewCell
        let meme = memes[indexPath.row]
        cell.memeView.image = meme.image
        cell.memeView.widthAnchor.constraint(equalToConstant: (view.frame.size.width * 0.65)).isActive = true
        cell.memeView.heightAnchor.constraint(equalToConstant: (cell.frame.height)).isActive = true
        cell.memeView.contentMode = .scaleAspectFit
        cell.topText.attributedText = NSAttributedString(string: meme.topText, attributes: memeTextAttributes)
        cell.bottomText.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeTextAttributes)
        cell.bottomTextTitle.text = meme.bottomText
        cell.topTextTitle.text = meme.topText
        return cell
    }
    
    @objc func addMeme() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeVC") as! MemeViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theMeme = memes[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "PreviewMeme") as! PreviewMemeViewController
        controller.theMeme = theMeme
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let meme = appDelegate.memes
        return meme
    }


}
