//
//  MovieCell.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 12.07.22.
//

import UIKit

protocol MovieCellDelegate {
    func addToSeen(cell: UITableViewCell)
}

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelImdb: UILabel!
    @IBOutlet weak var buttonSeen: UIButton!
    
    var delegate: MovieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSeenButton(_ sender: UIButton) {
        delegate?.addToSeen(cell: self)
    }
    
}
