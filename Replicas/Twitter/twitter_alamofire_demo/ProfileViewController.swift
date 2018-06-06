//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kode Williams on 4/23/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    let userDict: [String: Any] = User.current!.dictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        backgroundImageView.af_setImage(withURL: URL(string: userDict["profile_background_image_url_https"]! as! String)!)
        profileImageView.af_setImage(withURL: URL(string: userDict["profile_image_url_https"]! as! String)!)
        nameLabel.text = User.current!.name
        screenNameLabel.text = "@\(userDict["screen_name"]! as! String)"
        tweetCountLabel.text = "\(userDict["statuses_count"] ?? 0)"
        followingCountLabel.text = "\(userDict["friends_count"] ?? 0)"
        followersCountLabel.text = "\(userDict["followers_count"] ?? 0)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
