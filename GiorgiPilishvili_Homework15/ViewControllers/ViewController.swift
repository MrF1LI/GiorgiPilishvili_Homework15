//
//  ViewController.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 12.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    enum SortMethod {
        case seen
        case favourite
    }
    
    // MARK: Variables

    @IBOutlet weak var tableViewMovies: UITableView!
    @IBOutlet weak var collectionViewGenres: UICollectionView!
    
    var movies = [
        Movie(title: "Avatar", releaseDate: "2009", imdb: 7.9, genre: .action, mainActor: "Sam Worthington", seen: false, isFavourite: true),
        Movie(title: "I Am Legend", releaseDate: "2007", imdb: 7.2, genre: .drama, mainActor: "Will Smith", seen: false, isFavourite: false),
        Movie(title: "The Avengers", releaseDate: "2012", imdb: 8.1, genre: .action, mainActor: "Robert Downey Jr.", seen: true, isFavourite: false),
        Movie(title: "The Wolf of Wall Street", releaseDate: "2013", imdb: 8.2, genre: .comedy, mainActor: "Leonardo DiCaprio", seen: false, isFavourite: false),
        Movie(title: "Interstellar", releaseDate: "2014", imdb: 8.6, genre: .drama, mainActor: "Ellen Burstyn", seen: false, isFavourite: false),
        Movie(title: "Game of Thrones", releaseDate: "2011-", imdb: 9.5, genre: .drama, mainActor: "Peter Dinklage", seen: false, isFavourite: false),
        Movie(title: "Vikings", releaseDate: "2013–", imdb: 8.6, genre: .action, mainActor: "Travis Fimmel", seen: false, isFavourite: false),
        Movie(title: "Gotham", releaseDate: "2014–", imdb: 8.0, genre: .action, mainActor: "Ben McKenzie", seen: false, isFavourite: false),
        Movie(title: "Power", releaseDate: "2014–", imdb: 8.0, genre: .drama, mainActor: "Omari Hardwick", seen: false, isFavourite: false),
        Movie(title: "Narcos", releaseDate: "2015–", imdb: 8.9, genre: .drama, mainActor: "Wagner Moura", seen: false, isFavourite: false),
        Movie(title: "Breaking Bad", releaseDate: "2008–2013", imdb: 9.5, genre: .drama, mainActor: "Bryan Cranston", seen: true, isFavourite: false),
        Movie(title: "300", releaseDate: "2006", imdb: 7.7, genre: .drama, mainActor: "Gerard Butler", seen: true, isFavourite: false)
    ]
    
    let genres: [Genre] = [.all, .comedy, .action, .drama]
    
    var difDataSource: UICollectionViewDiffableDataSource<Section, Genre>!
    
    var sortMethod: SortMethod = .seen
//    var currentGenre: Genre = .all
    var currentGenres: [Genre] = [.all]
        
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        configureCollectionView()
    }
    
    // MARK: Functions
    
    func initTableView() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    
    @IBAction func changeSectionSorting(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Sort by seen", style: .default, handler: { alertAction in
            self.sortMethod = .seen
//            self.currentGenre = .all
            self.currentGenres = [.all]
            self.tableViewMovies.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by favourite", style: .default, handler: { alertAction in
            self.sortMethod = .favourite
//            self.currentGenre = .all
            self.currentGenres = [.all]
            self.tableViewMovies.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    
}
