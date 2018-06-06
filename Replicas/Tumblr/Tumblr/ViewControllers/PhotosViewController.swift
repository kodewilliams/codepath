//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Kode Williams on 2/4/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var photosTableView: UITableView!
    var posts: [[String: Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTableView.dataSource = self
        photosTableView.rowHeight = 400

        // Do any additional setup after loading the view.
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Get the posts and store in posts property
                
                // TODO: Reload the table view
                self.photosTableView.reloadData()
            }
        }
        task.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let photoUrl = URL(string: urlString)
            cell.photoImageView.af_setImage(withURL: photoUrl!)
        }
       
        // Set the post date above post
        if let postDate = post["date"] as? String {
            cell.postDateLabel.text = postDate
        }
        
        // Set the avatar image above post
        if let blogName = post["blog_name"] as? String {
            let avatarApiString = "https://api.tumblr.com/v2/blog/" + blogName + ".tumblr.com/avatar/128"
            print(avatarApiString)
            let avatarUrl = URL(string: avatarApiString)
            cell.avatarImageView.af_setImage(withURL: avatarUrl!)
            cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.height/2
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = photosTableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            if let photos = post["photos"] as? [[String: Any]] {
                let photo = photos[0]
                let originalSize = photo["original_size"] as! [String: Any]
                let photoString = originalSize["url"] as! String
                let photoDetailsViewController = segue.destination as! PhotoDetailsViewController
                photoDetailsViewController.photoURLString = photoString
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
