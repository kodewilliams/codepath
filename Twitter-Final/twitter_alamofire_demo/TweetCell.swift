//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var uniqueNameLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTapLike(_ sender: Any) {
        // TODO: Update the local tweet model
        // TODO: Update cell UI
        // TODO: Send a POST request to the POST favorites/create endpoint
        tweet.favorited = true
        tweet.favoriteCount = tweet.favoriteCount! + 1
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        tweet.retweeted = true
        tweet.retweetCount = tweet.retweetCount + 1
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
}
