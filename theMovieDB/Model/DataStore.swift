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
}
