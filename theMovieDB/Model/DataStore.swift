//
//  DataStore.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

/**
 A generic memory store for the data been fetched from TMDB API. Under normal conditions, this would have been a SQLite/Realm database or Core Data.
 */

typealias MovieDataType = Array<Movie>
typealias GenreDataType = Array<Genre>

class DataStore: NSObject {
	static var shared = DataStore()
	
	/**
	 An array containing the movies related to the search term.
	 Contents are updated (append) during the pagination process and cleared at user action.
	 */
	var data: MovieDataType = []
	
	/**
	 An array containing all TMDB genres.
	 The list is fetched at app start and data are cached for any later use.
	 */
	var genre: GenreDataType = []
	
	/// The number of total pages as reported in search response.
	var totalPages = 0
	
	/// The number of total results as reported in search response.
	var totalResults = 0
	
	/// Method to clear stored search data. Invoked by user action.
	func clearData() {
		self.data.removeAll()
		totalPages = 0
		totalResults = 0
	}
}
