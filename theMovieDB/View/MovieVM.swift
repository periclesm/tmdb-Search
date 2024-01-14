//
//  MovieVM.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class MovieVM: NSObject {
	
	///Object to contain the user selected movie.
	var movie: Movie? = nil
	

	func subtitleString() -> String {
		var subtitle = ""
		subtitle.append(contentsOf: MDDate.shared.convertDateFormat(inputString: self.movie?.releaseDate, fromFormat: .original, toFormat: .formatted))
		
		let genres = GenreController.getMovieGenres(self.movie)
		genres.isEmpty ? nil : subtitle.append(contentsOf: " • \(genres)")
		
		return subtitle
	}
	
	func releaseDateString() -> String {
		let formattedDate = MDDate.shared.convertDateFormat(inputString: self.movie?.releaseDate, fromFormat: .original, toFormat: .formatted)
		return "Release Date: \(formattedDate)"
	}
	
	func genresString() -> String {
		return GenreController.getMovieGenres(self.movie)
	}
	
	func ratingsString() -> String {
		var rating = ""
		rating.append(contentsOf: "⭐️ \(movie?.voteAverage ?? 0)")
		rating.append(contentsOf: " • \(movie?.voteCount ?? 0) votes")
		return rating
	}
}
