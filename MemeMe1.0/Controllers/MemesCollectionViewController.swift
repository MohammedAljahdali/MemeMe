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
        let height: CGFloat = (view.frame.size.width - space * 2) / 4
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        flowLayout.invalidateLayout()
           memes = {
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let meme = appDelegate.memes
               return meme
           }()
        collectionView.reloadData()
           // TODO: implment a method that give the memes var a updated list of all the memes from the delegate
    }
    
    @objc func addMeme() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeVC") as! MemeViewController
        navigationController?.pushViewController(controller, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemesCollectionViewCell
        let meme = memes[indexPath.row]
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        cell.memeView.image = meme.image
        cell.memeView.contentMode = .scaleAspectFit
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
