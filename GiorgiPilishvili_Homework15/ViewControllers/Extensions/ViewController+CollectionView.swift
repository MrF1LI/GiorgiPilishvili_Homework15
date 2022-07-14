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
    
    // DiffableDataSource
    
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
    
    // Cell click
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Change genre
        
        let genre = genres[indexPath.row]
        // self.currentGenre = genre
        
        if genre == .all {
            clearGenres()
        } else {
            // new
            
            if currentGenres == [.all] {
                currentGenres.removeAll()
                addGenre(indexPath: indexPath, genre: genre)
            } else {
                if !currentGenres.contains(genre) {
                    addGenre(indexPath: indexPath, genre: genre)
                } else {
                    removeGenre(indexPath: indexPath, genre: genre)
                }
            }
            
            // new
            
            tableViewMovies.reloadData()
        }
      
    }
    
    func addGenre(indexPath: IndexPath, genre: Genre) {
        
        currentGenres.append(genre)
        
        // Blur background image and change text to checkmark
        
        let currentCell = collectionViewGenres.cellForItem(at: indexPath) as! GenreCell
        currentCell.imageViewBackground.addBlur()
        currentCell.labelGenre.text = "✅"
        
    }
    
    func removeGenre(indexPath: IndexPath, genre: Genre) {
        let currentCell = collectionViewGenres.cellForItem(at: indexPath) as! GenreCell
        currentCell.labelGenre.text = genre.rawValue
        currentCell.imageViewBackground.removeBlur()
        
        currentGenres.removeAll { $0 == genre }
        if currentGenres.count == 0 {
            currentGenres = [.all]
        }
    }
    
    func clearGenres() {
        currentGenres = [.all]
        tableViewMovies.reloadData()
        collectionViewGenres.reloadData()
    }
    
}
