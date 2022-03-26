//
//  GenreController.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

class GenreController: NSObject {
	
	class func getMovieGenres(_ movie: Movie?) -> String {
		guard let inputMovie = movie else {
			return ""
		}
		
		var genreString = ""
		var index = 1
		
		if let genreArray = inputMovie.genre_ids {
			for id in genreArray {
				for genre in DataStore.shared.genre {
					if id == genre.id {
						genreString.append(contentsOf: "\(genre.name)")
						
						if index < genreArray.count {
							genreString.append(contentsOf: ", ")
							index+=1
						}
						
						break
					}
				}
			}
		}
		
		return genreString
	}
}
