//
//  CardsViewController.swift
//  Tinder
//
//  Created by Kode Williams on 4/17/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardInitialCenter = cardImageView.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCard(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "openProfile", sender: self)
    }
    
    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            print("Gesture began")
            
        }
        else if sender.state == .changed {
            
            if translation.x > 0 {
                cardImageView.center = CGPoint(x: self.cardInitialCenter.x + translation.x ,y: self.cardInitialCenter.y)
                cardImageView.transform = cardImageView.transform.rotated(by:0.003)
                
            } else if translation.x < 0 {
                cardImageView.center = CGPoint(x: self.cardInitialCenter.x + translation.x ,y: self.cardInitialCenter.y)
                cardImageView.transform = cardImageView.transform.rotated(by:-0.003)
            }
            print("Gesture is changing")
            
        } else if sender.state == .ended {
            
            print("Gesture ended")
            if translation.x > 50 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.cardImageView.center = CGPoint(x: self.cardInitialCenter.x + 500 ,y: self.cardInitialCenter.y)
                })
            }
            else if translation.x < -50 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.cardImageView.center = CGPoint(x: self.cardInitialCenter.x - 500 ,y: self.cardInitialCenter.y)
                })
            }
            else {
                cardImageView.center = cardInitialCenter
                cardImageView.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let vc = segue.destination as! ProfileViewController
        vc.profileImage = cardImageView.image!
    }

}
