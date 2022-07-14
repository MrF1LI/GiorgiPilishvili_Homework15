//
//  ViewController+SimpleExtensions.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import Foundation
import UIKit

// MARK: Extension for seen button click event

extension ViewController: MovieCellDelegate {
    
    func addToSeen(cell: UITableViewCell) {
        
        if let indexPath = tableViewMovies.indexPath(for: cell) {
            
            var currentMovieIndex: Int?
            if currentGenre == .all {
                if sortMethod == .favourite {
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
            } else {
                let movie = movies.filter { $0.genre == currentGenre }[indexPath.row]
                currentMovieIndex = movies.firstIndex(where: { $0.title == movie.title })
            }
            
            movies[currentMovieIndex ?? 0].seen = !movies[currentMovieIndex ?? 0].seen
            tableViewMovies.reloadData()
        }
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
