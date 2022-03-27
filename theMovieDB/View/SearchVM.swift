//
//  SearchVM.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVM: NSObject {
	
	let store = DataStore.shared
	var movies: MoviesDataType = []
	
	var pageIndex = 1
	var totalCount: Int {
		get {
			return store.totalResults
		}
	}
	
	func clearData() {
		self.movies.removeAll()
		store.clearData()
		pageIndex = 1
	}
	
	func getSearchData(searchTerm: String, completion: ((Bool) -> Void)? = nil) {
		DataManager().getData(searchTerm: searchTerm, page: pageIndex) { completed in
			self.movies = self.store.data
			completion?(completed)
		}
	}
	
	func pageIncrement() {
		if pageIndex < store.totalPages {
			pageIndex += 1
		}
	}
}
