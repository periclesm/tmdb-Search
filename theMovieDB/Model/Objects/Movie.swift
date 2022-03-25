//
//  Movie.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct Movie: Codable {
	
	var id: Int?
	var title: String?
	var overview: String?
	var release_date: String?
	
	var original_language: String?
	var original_title: String?
	
	var poster_path: String?
	var backdrop_path: String?
	
	var genre_ids: Array<Int>?
	
	var adult: Bool?
	
	var vote_average: Float?
	var vote_count: Float? //wtf? why float? are there 5.3 or 5.7 people voted????
}
