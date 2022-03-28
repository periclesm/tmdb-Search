//
//  DataAPI.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

enum ImageType {
	case poster, backdrop
}

class DataAPI: NSObject {
	
	var apiKey = "2810b46c0fe82e2e7eb43466581d495f"
	
	func createMovieEndoint(searchTerm: String, requestPage: Int = 1) -> URL? {
		let endpoint = String(format: "https://api.themoviedb.org/3/search/movie?api_key=%@&language=en-US&query=%@&page=%@&include_adult=false", apiKey, searchTerm, String(requestPage))
		
		let encodedEndpoint = self.encodeURL(endpoint)
		let endpointURL = URL(string: encodedEndpoint)
		
		return endpointURL
	}
	
	func createGenreEndpoint() -> URL? {
		let endpoint = String(format: "https://api.themoviedb.org/3/genre/movie/list?api_key=%@&language=en-US", apiKey)
		
		let encodedEndpoint = self.encodeURL(endpoint)
		let endpointURL = URL(string: encodedEndpoint)
		
		return endpointURL
	}
	
	func createImageEndpoint(imagePath: String, type: ImageType? = .poster) -> URL? {
		var endpoint = ""
		
		switch type {
		case .backdrop:
			endpoint = String(format: "https://www.themoviedb.org/t/p/w780%@", imagePath)
			
		default:
			endpoint = String(format: "https://www.themoviedb.org/t/p/w342%@", imagePath)
		}
		
		let encodedEndpoint = self.encodeURL(endpoint)
		let endpointURL = URL(string: encodedEndpoint)
		
		return endpointURL
	}
	
	private func encodeURL(_ urlString: String) -> String {
		if !urlString.isEmpty {
			if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
				return encodedString
			}
		}
		
		return ""
	}
}
