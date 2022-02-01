//
//  MovieDetailViewController.swift
//  ghibli
//
//  Created by Danilo Barreto on 01/02/22.
//

import Foundation
import UIKit

class MovieDetailViewController : UIViewController{
    var movieDetails : Movie?
    var image : UIImage?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poster.image = image
        movieTitle.text = movieDetails?.title
        movieDescription.text = movieDetails?.description
    }
}
