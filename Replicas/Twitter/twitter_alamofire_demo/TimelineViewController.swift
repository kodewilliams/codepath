//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    
    func did(post: Tweet) {
        getTweets()
        print(post.text)
    }
    
    
    var tweets: [Tweet] = []
    var selectedTweet: Tweet?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
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
        if (cell.tweet.favorited == true) {
            cell.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        if (cell.tweet.retweeted == true) {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
        selectedTweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedTweet = tweets[indexPath.row]
        self.performSegue(withIdentifier: "tweetSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tweetSegue") {
            let vc = segue.destination as! TweetViewController
            vc.tweet = selectedTweet
        }
        
        if (segue.identifier == "composeSegue") {
            let vc = segue.destination as! ComposeTweetViewController
            vc.delegate = self
        }
    }
    
}
