//
//  DataStore.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

typealias MoviesDataType = Array<Movie>
typealias GenreDataType = Array<Genre>

class DataStore: NSObject {
	static var shared = DataStore()
	
	var data: MoviesDataType = []
	var genre: GenreDataType = []
	
	var totalPages = 0
	var totalResults = 0
	
	func clearData() {
		self.data.removeAll()
		totalPages = 0
		totalResults = 0
	}
}
