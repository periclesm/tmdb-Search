//
//  DataStore.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

typealias MoviesDataType = Array<Movie>

class DataStore: NSObject {
	static var shared = DataStore()
	var data: MoviesDataType = []
}
