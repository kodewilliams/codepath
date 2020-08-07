//
//  TweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kode Williams on 4/23/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2

        // Do any additional setup after loading the view.
        nameLabel.text = tweet!.user.name
        screenNameLabel.text = "@\(tweet!.user.dictionary!["screen_name"]!)"
        tweetTextLabel.text = tweet!.text
        timestampLabel.text = tweet!.createdAtString
        retweetCountLabel.text = "\(tweet!.retweetCount)"
        favoriteCountLabel.text = "\(tweet!.favoriteCount ?? 0)"
        profileImageView.af_setImage(withURL: URL(string: tweet!.user.dictionary!["profile_image_url_https"]! as! String)!)
        if (tweet!.favorited == true) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        if (tweet!.retweeted == true) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
