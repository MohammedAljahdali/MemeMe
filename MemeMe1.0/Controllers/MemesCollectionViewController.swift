//
//  MemesCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 29/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemesCollectionViewController: UICollectionViewController {
    
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
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addMeme))
        let space: CGFloat = 1.5
        let width: CGFloat = (view.frame.size.width - space * 2) / 5
        let height: CGFloat = (view.frame.size.width - space * 2) / 3
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           memes = {
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let meme = appDelegate.memes
               return meme
           }()
        flowLayout.invalidateLayout()
        collectionView.reloadData()
           // TODO: implment a method that give the memes var a updated list of all the memes from the delegate
    }
    
    @objc func addMeme() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeVC") as! MemeViewController
        navigationController?.pushViewController(controller, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theMeme = memes[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "PreviewMeme") as! PreviewMemeViewController
        controller.theMeme = theMeme
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemesCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.memeView.image = meme.meme
        cell.memeView.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 2 * 2) / 5).isActive = true
        cell.memeView.heightAnchor.constraint(equalToConstant: (view.frame.size.width - 2 * 2) / 3).isActive = true
        cell.memeView.contentMode = .scaleAspectFit
        return cell
    }

}
