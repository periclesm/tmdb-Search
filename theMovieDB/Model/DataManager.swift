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
			//send <no_search_term> error
			completion(false)
			return
		}
		
		if let endpoint = api.createMovieEndoint(searchTerm: searchString, requestPage: page) {
			Network().getData(endpoint: endpoint) { data, error in
				if error == nil {
					//parse data
					if let responseData = data {
						let response: Response = self.parseData(data: responseData)
						DataStore.shared.data.append(contentsOf: response.results)
						completion(true)
					}
					else {
						//send <no_data> error
						completion(false)
					}
					
				}
				else {
					//send <error.localizedString> error
					completion(false)
				}
			}
		}
		else {
			//send <endpoint_failure> error
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
					completion?(false)
				}
			}
		}
		else {
			completion?(false)
		}
	}
	
	func getImage(imagePath: String?, completion: @escaping ((UIImage?) -> Void)) {
		let api = DataAPI()
		
		guard let pathString = imagePath else {
			//send <no_image_path> error
			completion(nil)
			return
		}
		
		if let imageURL = api.createImageEndpoint(imagePath: pathString) {
			Network().getData(endpoint: imageURL) { data, error in
				if error == nil {
					if data != nil {
						let image = UIImage(data: data!)
						completion(image)
					}
					else {
						//send <no_image_data> error
						completion(nil)
					}
				}
				else {
					//send <error.localizedString> error
					completion(nil)
				}
			}
		}
		else {
			//send <endpoint_failure> error
			completion(nil)
		}
	}
	
	private func parseData<T: Decodable>(data: Data) -> T {
		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			debugPrint("Parsing error: \(error.localizedDescription)")
			fatalError("error in decoding")
		}
	}
}

