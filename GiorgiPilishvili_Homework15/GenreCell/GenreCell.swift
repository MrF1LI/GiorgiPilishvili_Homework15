//
//  GenreCell.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    let images: [Genre:UIImage] = [
        .all: UIImage(named: "genreAll")!,
        .comedy: UIImage(named: "genreComedy")!,
        .action: UIImage(named: "genreAction")!,
        .drama: UIImage(named: "genreDrama")!
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureDesign()
    }
    
    func configureDesign() {
        imageViewBackground.layer.cornerRadius = 10
    }
    
    func setInformation(genre: Genre) {
        imageViewBackground.removeBlur()
        labelGenre.setOutLinedText(genre.rawValue)
        imageViewBackground.image = images[genre]
    }

}
