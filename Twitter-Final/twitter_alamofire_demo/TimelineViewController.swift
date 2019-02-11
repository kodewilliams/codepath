//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        getTweets()
        
    }
    
    @objc func refreshTweets(_ refreshControl: UIRefreshControl) {
        getTweets()
        refreshControl.endRefreshing()
        print("Refreshed")
    }
    
    func getTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.retweetsCountLabel.text = "\(cell.tweet.retweetCount)"
        cell.likesCountLabel.text = "\(cell.tweet.favoriteCount!)"
        cell.usernameLabel.text = cell.tweet.user.name
        let userDetails = cell.tweet.user.dictionary!
        let uniqueName = userDetails["screen_name"] as! String
        let aviUrlString = userDetails["profile_background_image_url_https"] as? String ?? "https://goo.gl/zxU9nF"
        let aviUrl = URL(string: aviUrlString)
        let timestamp = cell.tweet.createdAtString
        
        cell.timestampLabel.text = timestamp
        cell.uniqueNameLabel.text = uniqueName
        cell.profilePictureImageView.af_setImage(withURL: aviUrl!)
        cell.profilePictureImageView.layer.cornerRadius = cell.profilePictureImageView.frame.width / 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
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
