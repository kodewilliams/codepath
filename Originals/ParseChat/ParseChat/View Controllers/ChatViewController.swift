//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Kode Williams on 2/26/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    // properties/fields must be declared here
    // @NSManaged to tell compiler these are dynamic properties
    // See https://stackoverflow.com/questions/31357564/what-does-nsmanaged-do
    @NSManaged var text: String
    @NSManaged var username: String
    
    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Message"
    }
}

class ChatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var messages: [PFObject] = []
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.darkText
        self.refresher.addTarget(self, action: #selector(getMessages), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // Get saved messages every second
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getMessages), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let singleMessage = self.messages[indexPath.row] as! Message
        let messageString = singleMessage.text
        let usernameString = singleMessage.username
        cell.messageLabel.text = messageString
        cell.usernameLabel.text = usernameString
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return messages.count
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = Message()
        chatMessage.username = PFUser.current()?.username as! String
        chatMessage.text = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func getMessages() {
        let predicate = NSPredicate(format: "text != ''")
        let query = Message.query(with: predicate)
        query?.addAscendingOrder("createdAt")
        
        query?.findObjectsInBackground { (msgs: [PFObject]?, error: Error?) in
            if let msgs = msgs {
                self.messages = msgs
                self.collectionView.reloadData()
            } else {
                print("Error retrieving messages")
            }
        }
        stopRefresher()
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
}
