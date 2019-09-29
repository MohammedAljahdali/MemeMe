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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addMeme))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let meme = appDelegate.memes
            return meme
        }()
        // TODO: implment a method that give the memes var a updated list of all the memes from the delegate
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemesTableViewCell
        let meme = memes[indexPath.row]
        cell.memeView.image = meme.image
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        return cell
    }
    
    @objc func addMeme() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeVC") as! MemeViewController
        navigationController?.pushViewController(controller, animated: true)
    }


}
