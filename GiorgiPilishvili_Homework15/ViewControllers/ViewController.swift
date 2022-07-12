//
//  ViewController.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 12.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables

    @IBOutlet weak var tableViewMovies: UITableView!
    
    var movies = [
        Movie(title: "Avatar", releaseDate: "2009", imdb: 7.9, mainActor: "Sam Worthington", seen: false, isFavourite: true),
        Movie(title: "I Am Legend", releaseDate: "2007", imdb: 7.2, mainActor: "Will Smith", seen: false, isFavourite: false),
        Movie(title: "The Avengers", releaseDate: "2012", imdb: 8.1, mainActor: "Robert Downey Jr.", seen: true, isFavourite: false),
        Movie(title: "The Wolf of Wall Street", releaseDate: "2013", imdb: 8.2, mainActor: "Leonardo DiCaprio", seen: false, isFavourite: false),
        Movie(title: "Interstellar", releaseDate: "2014", imdb: 8.6, mainActor: "Ellen Burstyn", seen: false, isFavourite: false),
        Movie(title: "Game of Thrones", releaseDate: "2011-", imdb: 9.5, mainActor: "Peter Dinklage", seen: false, isFavourite: false),
        Movie(title: "Vikings", releaseDate: "2013–", imdb: 8.6, mainActor: "Travis Fimmel", seen: false, isFavourite: false),
        Movie(title: "Gotham", releaseDate: "2014–", imdb: 8.0, mainActor: "Ben McKenzie", seen: false, isFavourite: false),
        Movie(title: "Power", releaseDate: "2014–", imdb: 8.0, mainActor: "Omari Hardwick", seen: false, isFavourite: false),
        Movie(title: "Narcos", releaseDate: "2015–", imdb: 8.9, mainActor: "Wagner Moura", seen: false, isFavourite: false),
        Movie(title: "Breaking Bad", releaseDate: "2008–2013", imdb: 9.5, mainActor: "Bryan Cranston", seen: true, isFavourite: false),
        Movie(title: "300", releaseDate: "2006", imdb: 7.7, mainActor: "Gerard Butler", seen: true, isFavourite: false)
    ]
    
    var sortMethod = "seen"
        
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
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
            self.sortMethod = "seen"
            self.tableViewMovies.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by favourite", style: .default, handler: { alertAction in
            self.sortMethod = "favourite"
            self.tableViewMovies.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    
}

// MARK: Extension for seen button click event

extension ViewController: MovieCellDelegate {
    
    func addToSeen(cell: UITableViewCell) {
        if let indexPath = tableViewMovies.indexPath(for: cell) {
            
            var currentMovieIndex: Int?
            
            if sortMethod == "favourite" {
                if indexPath.section == 0 {
                    let movie = movies.filter { $0.isFavourite }[indexPath.row]
                    currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })
                } else {
                    let movie = movies.filter { !$0.isFavourite }[indexPath.row]
                    currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })
                }
            } else {
                if indexPath.section == 0 {
                    let movie = movies.filter { $0.seen }[indexPath.row]
                    currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })
                } else {
                    let movie = movies.filter { !$0.seen }[indexPath.row]
                    currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })
                }
            }
            
            movies[currentMovieIndex ?? 0].seen = !movies[currentMovieIndex ?? 0].seen
            tableViewMovies.reloadData()
        }
    }
    
}

// MARK: Extension for table view

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sortMethod == "favourite" {
            return section == 0 ? movies.filter { $0.isFavourite }.count : movies.filter { !$0.isFavourite }.count
        } else {
            return section == 0 ? movies.filter { $0.seen }.count : movies.filter { !$0.seen }.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell =  tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        guard let cell = cell else { return UITableViewCell() }
        
        var currentMovie: Movie?
        
        if sortMethod == "favourite" {
            if indexPath.section == 0 {
                currentMovie = movies.filter { $0.isFavourite }[indexPath.row]
            } else {
                currentMovie = movies.filter { !$0.isFavourite }[indexPath.row]
            }
        } else {
            if indexPath.section == 0 {
                currentMovie = movies.filter { $0.seen }[indexPath.row]
            } else {
                currentMovie = movies.filter { !$0.seen }[indexPath.row]
            }
        }
        
        // Set button icon
        
        guard let isSeen = currentMovie?.seen else { return UITableViewCell() }
        
        if isSeen {
            cell.buttonSeen.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            cell.buttonSeen.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        
        //
                
        cell.labelTitle.text = currentMovie?.title
        cell.labelImdb.text = "IMDB: \(currentMovie?.imdb ?? 0)"
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                
        if sortMethod == "favourite" {
            
            // Show title if section is not empty
            
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return section == 0 ? "Favourite" : "Other"
            } else {
                return nil
            }
            
        } else {
            
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return section == 0 ? "Seen" : "Other"
            } else {
                return nil
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController")
        guard let vc = vc else { return }
        
        if sortMethod == "favourite" {
            if indexPath.section == 0 {
                (vc as? DetailsViewController)?.movie = movies.filter { $0.isFavourite }[indexPath.row]
            } else {
                (vc as? DetailsViewController)?.movie = movies.filter { !$0.isFavourite }[indexPath.row]
            }
        } else {
            if indexPath.section == 0 {
                (vc as? DetailsViewController)?.movie = movies.filter { $0.seen }[indexPath.row]
            } else {
                (vc as? DetailsViewController)?.movie = movies.filter { !$0.seen }[indexPath.row]
            }
        }
        
        (vc as? DetailsViewController)?.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: Extension for change favourite state

extension ViewController: DetailsViewControllerDelegate {
    
    func changeFavouriteState(for movie: Movie) {
        
        let currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })

        guard let currentMovieIndex = currentMovieIndex else { return }
        
        movies[currentMovieIndex].isFavourite = !movies[currentMovieIndex].isFavourite
        tableViewMovies.reloadData()
    }
    
}
