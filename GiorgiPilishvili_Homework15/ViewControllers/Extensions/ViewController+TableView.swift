//
//  ViewController+TableView.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentGenre == .all {
            if sortMethod == .favourite {
                return section == 0 ? movies.filter { $0.isFavourite }.count : movies.filter { !$0.isFavourite }.count
            } else {
                return section == 0 ? movies.filter { $0.seen }.count : movies.filter { !$0.seen }.count
            }
        } else {
            return movies.filter { $0.genre == currentGenre }.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell =  tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        guard let cell = cell else { return UITableViewCell() }
        
        var currentMovie: Movie?
        
        if currentGenre == .all {
            if sortMethod == .favourite {
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
        } else {
            currentMovie = movies.filter { $0.genre == currentGenre }[indexPath.row]
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
        currentGenre == .all ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if currentGenre == .all {
            if sortMethod == .favourite {
                
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
        } else {
            
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return currentGenre.rawValue
            } else {
                return nil
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        var currentMovie: Movie
        
        if currentGenre == .all {
            
            if sortMethod == .favourite {
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
            
        } else {
            currentMovie = movies.filter { $0.genre == currentGenre }[indexPath.row]
        }
        
        vc.movie = currentMovie
        vc.movies = movies.filter { $0.genre == currentMovie.genre }
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
