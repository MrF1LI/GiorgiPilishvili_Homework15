//
//  CollMovieCell.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import UIKit

class CollMovieCell: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelImdb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureDesign()
    }
    
    func configureDesign() {
        self.layer.cornerRadius = 5
    }
    
    func setInformation(movie: Movie) {
        labelTitle.text = movie.title
        labelImdb.text = "IMDB: \(movie.imdb)"
    }

}
