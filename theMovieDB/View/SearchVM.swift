//
//  SearchVM.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVM: NSObject {
	
	var movies: MoviesDataType = []
	var pageIndex = 1
	
	func getSearchData(searchTerm: String, completion: @escaping ((Bool) -> Void)) {
		DataManager().getData(searchTerm: searchTerm, page: pageIndex) { completed in
			self.movies = DataStore.shared.data
			completion(completed)
		}
	}
}
