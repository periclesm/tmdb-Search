//
//  SearchVM.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVM: NSObject {
	
	let store = DataStore.shared
	
	///Array with all movies to be used in UITableView cells.
	var movies: MoviesDataType = []
	
	///The current page index.
	var pageIndex = 1
	
	///The total results count from the response payload. This is a read-only value from the `DataStore`.
	var totalCount: Int {
		get {
			return store.totalResults
		}
	}
	
	///Clears all data from VM and DataStore and resets counters.
	func clearData() {
		self.movies.removeAll()
		store.clearData()
		pageIndex = 1
	}
	
	/**
	 Performs the search and fills the movies array with results
	 Completion, if successful, will reload the UITableView and display what has been fetched.
	 */
	func getSearchData(searchTerm: String, completion: ((Bool) -> Void)? = nil) {
		DataManager().getData(searchTerm: searchTerm, page: pageIndex) { completed in
			self.movies = self.store.data
			completion?(completed)
		}
	}
	
	///Increments the pageIndex up to the count of total pages as reported in the API payload.
	func pageIncrement() {
		if pageIndex < store.totalPages {
			pageIndex += 1
		}
	}
}
