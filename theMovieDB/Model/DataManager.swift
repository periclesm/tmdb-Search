//
//  DataManager.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class DataManager: NSObject {

	func getData(searchTerm: String?, page: Int = 1, completion: @escaping ((Bool) -> Void)) {
		let api = DataAPI()
		
		guard let searchString = searchTerm else {
			debugPrint("[tmdb-DataManager] send <no_search_term> error")
			completion(false)
			return
		}
		
		if let endpoint = api.createMovieEndoint(searchTerm: searchString, requestPage: page) {
			Network().getData(endpoint: endpoint) { data, error in
				if error == nil {
					//parse data
					if let responseData = data {
						let response: Search = self.parseData(data: responseData)
						
						let store = DataStore.shared
						store.data.append(contentsOf: response.results)
						store.totalResults = response.total_results
						store.totalPages = response.total_pages
						
						completion(true)
					}
					else {
						debugPrint("[tmdb-DataManager] send <no_data> error")
						completion(false)
					}
					
				}
				else {
					debugPrint("[tmdb-DataManager] send <\(error?.localizedDescription ?? "error.localizedDescription")> error")
					completion(false)
				}
			}
		}
		else {
			debugPrint("[tmdb-DataManager] send <endpoint_failure> error")
			completion(false)
		}
	}
	
	func getGenres(completion: ((Bool) -> Void)? = nil) {
		let api = DataAPI()
		
		if let genreURL = api.createGenreEndpoint() {
			Network().getData(endpoint: genreURL) { data, error in
				if let responseData = data {
					let genreResponse: GenreResponse = self.parseData(data: responseData)

					DataStore.shared.genre = genreResponse.genres
					completion?(true)
				}
				else {
					debugPrint("[tmdb-DataManager] send <endpoint_failure> error")
					completion?(false)
				}
			}
		}
		else {
			debugPrint("[tmdb-DataManager] send <endpoint_failure> error")
			completion?(false)
		}
	}
	
	func getImage(imagePath: String?, type: ImageType? = .poster, completion: @escaping ((UIImage?) -> Void)) {
		let api = DataAPI()
		
		guard let pathString = imagePath else {
			debugPrint("[tmdb-DataManager] send <no_image_path> error")
			completion(nil)
			return
		}
		
		if let imageURL = api.createImageEndpoint(imagePath: pathString, type: type) {
			Network().getData(endpoint: imageURL) { data, error in
				if error == nil {
					if data != nil {
						let image = UIImage(data: data!)
						completion(image)
					}
					else {
						debugPrint("[tmdb-DataManager] send <no_image_data> error")
						completion(nil)
					}
				}
				else {
					debugPrint("[tmdb-DataManager] send <\(error?.localizedDescription ?? "error.localizedDescription")> error")
					completion(nil)
				}
			}
		}
		else {
			debugPrint("[tmdb-DataManager] send <endpoint_failure> error")
			completion(nil)
		}
	}
	
	//MARK: - Data Parsing
	
	func parseData<T: Decodable>(data: Data) -> T {
		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			debugPrint("Parsing error: \(error.localizedDescription)")
			fatalError("error in decoding")
		}
	}
}

