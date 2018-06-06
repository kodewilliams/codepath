//
//  MovieDetailViewController.swift
//  flix-demo
//
//  Created by Kode Williams on 2/11/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailPoster: UIImageView!
    @IBOutlet weak var movieDetailName: UILabel!
    @IBOutlet weak var movieDetailReleaseDate: UILabel!
    @IBOutlet weak var movieDetailOverview: UILabel!
    
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let movie  = movie {
            movieDetailName.text = movie["title"] as? String
            movieDetailReleaseDate.text = movie["release_date"] as? String
            movieDetailOverview.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseUrlString + backdropPathString)!
            movieDetailImage.af_setImage(withURL: backdropURL)
            let posterURL = URL(string: baseUrlString + posterPathString)!
            movieDetailPoster.af_setImage(withURL: posterURL)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
