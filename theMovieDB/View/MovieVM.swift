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
	
	/**
	 Formats the subtitle string to contain the movie release date and genres.
	 Since this string is used only in MovieVC, it is placed in MovieVM (also: placed here because it performs data operations).
	 If this string format were needed in other VCs, its appropriate place would have been in the Domain section.
	 */
	func subtitleString() -> String {
		var subtitle = ""
		subtitle.append(contentsOf: MDDate.shared.convertDateFormat(inputString: self.movie?.release_date, fromFormat: .original, toFormat: .formatted))
		
		let genres = GenreController.getMovieGenres(self.movie)
		genres.isEmpty ? nil : subtitle.append(contentsOf: " • \(genres)")
		
		return subtitle
	}
}
