//
//  DetailsViewController+UICollectionView.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import Foundation
import UIKit

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    enum Section {
        case one
    }
    
    // Cell size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 160, height: 90)
    }
    
    // Config collection view
    
    func configureCollectionView() {
        collectionViewMovies.delegate = self
        collectionViewMovies.registerNib(class: CollMovieCell.self)
        
        createDifDatasource()
    }
    
    // Cell click
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentMovie = filteredMovies[indexPath.row]
        self.movie = currentMovie
        initMovieDetails()
        initFavouriteButton()
        collectionView.reloadData()
    }
    
    func createDifDatasource() {
        
        difDataSource = UICollectionViewDiffableDataSource(collectionView: collectionViewMovies, cellProvider: { collectionView, indexPath, genre in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollMovieCell", for: indexPath) as! CollMovieCell
            
            let currentMovie = self.filteredMovies[indexPath.row]
            cell.setInformation(movie: currentMovie)
            
            return cell
        })
        
        var screenshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        screenshot.appendSections([.one])
        screenshot.appendItems(filteredMovies, toSection: .one)
        difDataSource.apply(screenshot)
    }
    
}
