//
//  Movie.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct Movie: Codable {
	
	var id: Int
	var title: String
	var overview: String
	var release_date: String
	
	var original_language: String
	var original_title: String
	
	var poster_path: String?
	var backdrop_path: String
	
	var genre_ids: Array<Int>
	
	var adult: Bool
	
	var vote_average: Int
	var vote_count: Int //not to be used
	var popularity: Int //not to be used
}
