//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Kode Williams on 2/11/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    var photoURLString: String = ""
    
    @IBOutlet weak var singlePhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let photoURL = URL(string: photoURLString)
        singlePhotoImageView.af_setImage(withURL: photoURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
