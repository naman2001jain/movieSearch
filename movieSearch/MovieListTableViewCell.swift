//
//  MovieListTableViewCell.swift
//  movieSearch
//
//  Created by naman  jain on 19/02/22.
//

import UIKit
import SDWebImage


class MovieListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLbl: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var movieTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setData(imageUrl: URL, title: String, description: String){
        self.moviePosterImageView.sd_setImage(with: imageUrl, completed: nil)
        self.movieTitleLbl.text = title
        self.movieDescriptionLbl.text = description
    }
    
    
    
}
