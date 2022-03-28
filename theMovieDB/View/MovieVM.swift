//
//  MovieVM.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class MovieVM: NSObject {
	
	var movie: Movie? = nil
	
	func subtitleString() -> String {
		var subtitle = ""
		subtitle.append(contentsOf: MDDate.shared.convertDateFormat(inputString: self.movie?.release_date, fromFormat: .original, toFormat: .formatted))
		
		let genres = GenreController.getMovieGenres(self.movie)
		genres.isEmpty ? nil : subtitle.append(contentsOf: " • \(genres)")
		
		return subtitle
	}
}
