//
//  DataManager.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class DataManager: NSObject {

	/**
	 Method to fetch data for the movie search. It fetches data from the internet, parses the data and stores them in the designed location.
	 - Parameter searchTerm: String The search string the user typed.
	 - Parameter page: Int The page of the search. Defaults to page 1 when the search is done for the first time.
	 */
	func getData(searchTerm: String?, page: Int = 1, completion: @escaping ((Bool) -> Void)) {
		let api = DataAPI()
		
		//First check if the search term is nil. If it is, return with error.
		guard let searchString = searchTerm else {
			debugPrint("[tmdb-DataManager] send <no_search_term> error")
			completion(false)
			return
		}
		
		//Create and check the URL endpoint.
		if let endpoint = api.createSearchMovieEndoint(searchTerm: searchString, page: page) {
			
			//Use Network to fetch data.
			Network().getData(endpoint: endpoint) { data, error in
				if error == nil {
					
					//If data have been received without error and are not nil, parse them.
					if let responseData = data {
						let response: SearchResponse = self.parseData(data: responseData)
						
						//Finally, store the necessary data in their objects.
						let store = DataStore.shared
						store.data.append(contentsOf: response.results)
						store.totalResults = response.totalResults
						store.totalPages = response.totalPages
						
						completion(true)
					}
					else {
						//Return error is data object is empty.
						debugPrint("[tmdb-DataManager] send <no_data> error")
						completion(false)
					}
					
				}
				else {
					//Return error message if there was an error reported from Network.
					debugPrint("[tmdb-DataManager] send <\(error?.localizedDescription ?? "error.localizedDescription")> error")
					completion(false)
				}
			}
		}
		else {
			//Report error if the end point is nil (ex. malformed)
			debugPrint("[tmdb-DataManager] send <endpoint_failure> error")
			completion(false)
		}
	}
	
	/**
	 Method to fetch data for all TMDB movie genres. It fetches data from the internet, parses the data and stores them in the designed location.
	 */
	func getGenres(completion: ((Bool) -> Void)? = nil) {
		let api = DataAPI()
		
		if let genreURL = api.createGenreEndpoint() {
			
			//Fetch Data
			Network().getData(endpoint: genreURL) { data, error in
				if let responseData = data {
					
					//Parse data
					let genreResponse: GenreResponse = self.parseData(data: responseData)

					//Store Data
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
	
	/**
	 Method to fetch data for an image. It fetches data from the internet, parses the data and stores them in the designed location.
	 - Parameter searchTerm: String The search string the user typed.
	 - Parameter page: Int The page of the search. Defaults to page 1 when the search is done for the first time.
	 */
	func getImage(imagePath: String?, type: ImageType? = .poster, completion: @escaping ((UIImage?) -> Void)) {
		let api = DataAPI()
		
		//Check imagePath in case it's empty (can be if the movie has no poster or backdrop)
		guard let pathString = imagePath else {
			debugPrint("[tmdb-DataManager] send <no_image_path> error")
			completion(nil)
			return
		}
		
		//Check image URL
		if let imageURL = api.createImageEndpoint(imagePath: pathString, type: type) {
			
			//Fetch Data
			Network().getData(endpoint: imageURL) { data, error in
				if error == nil {
					if data != nil {
						
						//Convert the received (image) data into a UIImage object and return it.
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
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(T.self, from: data)
		} catch {
			debugPrint("Parsing error: \(error.localizedDescription)")
			fatalError("error in decoding")
		}
	}
}

