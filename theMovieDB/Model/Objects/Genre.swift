//
//  Genre.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct GenreResponse: Codable {
	var genres: [Genre]
}

struct Genre: Codable {
	var id: Int
	var name: String
}
