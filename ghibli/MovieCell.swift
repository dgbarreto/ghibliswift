//
//  MovieCell.swift
//  ghibli
//
//  Created by Danilo Barreto on 13/01/22.
//

import Foundation
import UIKit

class MovieCell : UICollectionViewCell {
    required init?(coder:NSCoder){
        super.init(coder: coder)
    }
    @IBOutlet var AlbumImage : UIImageView?
    @IBOutlet weak var Title: UITextView!
    var movieDetails : Movie?
}
