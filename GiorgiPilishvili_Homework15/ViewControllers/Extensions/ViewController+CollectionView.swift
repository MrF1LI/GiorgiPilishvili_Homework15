//
//  ViewController+CollectionView.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    enum Section {
        case one
    }

    // Cell size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 90)
    }
    
    // Config collection view
    
    func configureCollectionView() {
        collectionViewGenres.delegate = self
        collectionViewGenres.registerNib(class: GenreCell.self)
        
        createDifDatasource()
    }
    
    // Cell click
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let genre = genres[indexPath.row]
        self.currentGenre = genre
        tableViewMovies.reloadData()
    }
    
    func createDifDatasource() {
        
        difDataSource = UICollectionViewDiffableDataSource(collectionView: collectionViewGenres, cellProvider: { collectionView, indexPath, genre in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
            
            let currentGenre = self.genres[indexPath.row]
            cell.setInformation(genre: currentGenre)
            
            return cell
        })
        var screenshot = NSDiffableDataSourceSnapshot<Section,Genre>()
        screenshot.appendSections([.one])
        screenshot.appendItems(genres, toSection: .one)
        difDataSource.apply(screenshot)
    }
    
}
