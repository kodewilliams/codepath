//
//  ComposeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kode Williams on 4/23/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetBodyTextView: UITextView!
    weak var delegate: ComposeViewControllerDelegate?
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetBodyTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Tweet successfully posted.")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.text != "") {
            self.placeholderLabel.isHidden = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        characterCountLabel.text = "\(characterLimit - newText.count)"
        
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetBodyTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

}
