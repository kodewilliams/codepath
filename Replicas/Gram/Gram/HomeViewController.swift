//
//  HomeViewController.swift
//  Gram
//
//  Created by Kode Williams on 3/6/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource {

    var window: UIWindow?
    @IBOutlet weak var tableView: UITableView!
    var feedPosts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        getPosts()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getPosts), userInfo: nil, repeats: true)
        
        self.tableView.estimatedRowHeight = 275
        self.tableView.rowHeight = 275
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getPosts()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageFeedCell", for: indexPath) as! ImageFeedCell
        let currentPost = feedPosts[indexPath.row] as! Post
        cell.postCaptionLabel.text = currentPost.caption
        
        cell.postImageView.file = currentPost.media
        cell.postImageView.loadInBackground()
        
        return cell
    }
    
    @objc func getPosts() {
        // construct query
        let query = Post.query()
        // query.whereKey("likesCount", greaterThan: 100)
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.feedPosts = posts
                self.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
        
        print(feedPosts);
    }
    
    @IBAction func logoutUser(_ sender: UIBarButtonItem) {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful logout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(vc, animated: true, completion: nil)
            }
        })
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
