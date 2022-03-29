//
//  GenreController.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation
/**
 GenreConrtoller is an indicative class of operations in the Domain section.
 It can be accessed by any class at any time.
 */
class GenreController: NSObject {
	
	/**
	 Having as input a movie object, this function takes `the genre_ids` and cross-references them by id with the TMDB Genres stored in `DataStore`
	 Then creates a string containing the actual genre names (input example: [1,5,8] -- output example: "Action, Adventure, Sci-Fi"
	 - Returns: A String with the movie genres.
	 */
	class func getMovieGenres(_ movie: Movie?) -> String {
		guard let inputMovie = movie else {
			return ""
		}
		
		//Movies with no genre should return an empty string.
		var genreString = ""
		var index = 1
		
		if let genreArray = inputMovie.genreIds {
			for id in genreArray {
				for genre in DataStore.shared.genre {
					if id == genre.id {
						genreString.append(contentsOf: "\(genre.name)")
						
						/*
						 Special care for the genre separator here.
						 For movies with more than one genre, the comma-space separator is used except the last one (ex. "Action<comma-space>Adventure<end>"
						 */
						if index < genreArray.count {
							genreString.append(contentsOf: ", ")
							index+=1
						}
						
						//Stop the loop when there is an id and genre.id match. Proceed then to the next id.
						break
					}
				}
			}
		}
		
		return genreString
	}
}
