//
//  AppDelegate.swift
//  MemeMe1.0
//
//  Created by Mohammed Khakidaljahdali on 20/09/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes: [Meme] = [
        Meme(topText: "hello", bottomText: "world", image: UIImage(named: "MemeGenerator_120 copy")!, meme: UIImage(named: "MemeGenerator_120 copy")!),
        Meme(topText: "hello", bottomText: "world", image: UIImage(named: "MemeGenerator_120 copy")!, meme: UIImage(named: "MemeGenerator_120 copy")!),
        Meme(topText: "hello", bottomText: "world", image: UIImage(named: "MemeGenerator_120 copy")!, meme: UIImage(named: "MemeGenerator_120 copy")!),
        Meme(topText: "hello", bottomText: "world", image: UIImage(named: "MemeGenerator_120 copy")!, meme: UIImage(named: "MemeGenerator_120 copy")!)
    ]
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -1.0
    ]
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

