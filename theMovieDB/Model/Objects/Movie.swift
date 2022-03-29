//
//  Movie.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct Movie: Decodable {
	
	var id: Int?
	var title: String?
	var overview: String?
	var releaseDate: String?
	
	var posterPath: String?
	var backdropPath: String?
	
	var genreIds: Array<Int>?
	
	var adult: Bool?
	
	var voteAverage: Float?
	var voteCount: Int32?
}
