//
//  DetailsViewController.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 12.07.22.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func changeFavouriteState(for movie: Movie)
}

class DetailsViewController: UIViewController {
    
    // MARK: Variables
    
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelImdb: UILabel!
    @IBOutlet weak var labelMainActor: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonFavourite: UIButton!
    
    var movie: Movie?
    var delegate: DetailsViewControllerDelegate?
    
    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMovieDetails()
        initFavouriteButton()
    }
    
    // MARK: Functions
    
    @IBAction func favouritesButtonPressed(_ sender: UIButton) {
        guard let movie = movie else { return }
        delegate?.changeFavouriteState(for: movie)
        updateFavouriteButton()
    }
    
    func initMovieDetails() {
        guard let movie = movie else { return }
        
        self.navigationItem.title = movie.title
        
        labelReleaseDate.text = movie.releaseDate
        labelImdb.text = "\(movie.imdb)"
        labelMainActor.text = movie.mainActor
        labelDescription.text = movie.description
    }
    
    func initFavouriteButton() {
        guard let movie = movie else { return }
        if movie.isFavourite {
            buttonFavourite.setTitle(" Remove from favourites", for: .normal)
            buttonFavourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            buttonFavourite.setTitle(" Add to favourites", for: .normal)
            buttonFavourite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func updateFavouriteButton() {
        if buttonFavourite.titleLabel?.text == " Remove from favourites"  {
            buttonFavourite.setTitle(" Add to favourites", for: .normal)
            buttonFavourite.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            buttonFavourite.setTitle(" Remove from favourites", for: .normal)
            buttonFavourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }

}
