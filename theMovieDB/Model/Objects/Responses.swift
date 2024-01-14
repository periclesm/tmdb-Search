//
//  Response.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct SearchResponse: Decodable {
	var page: Int
	var totalPages: Int
	var totalResults: Int
	var results: MovieDataType = []
}

struct GenreResponse: Decodable {
	var genres: GenreDataType = []
}
