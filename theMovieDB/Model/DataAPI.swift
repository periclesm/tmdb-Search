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
	
	/*
	 Create an account in MovieDb (https://www.themoviedb.org/) and get your API key from account settings.
	 Add your API key below to use the app.
	 */
	
	var apiKey = <#T##Insert your API KEY here#>
	
	/**
	 Creates the search movie API endpoint.
	 - Parameter searchTerm: String The search string the user typed.
	 - Parameter page: Int The page of the search. Defaults to page 1 when the search is done for the first time.
	 - Returns: `URL` The url to be used in Network module.
	 */
	func createSearchMovieEndoint(searchTerm: String, page: Int = 1) -> URL? {
		let endpoint = String(format: "https://api.themoviedb.org/3/search/movie?api_key=%@&language=en-US&query=%@&page=%@&include_adult=false", apiKey, searchTerm, String(page))
		
		let encodedEndpoint = self.encodeURL(endpoint)
		let endpointURL = URL(string: encodedEndpoint)
		
		return endpointURL
	}
	
	/**
	 Creates the genre API endpoint.
	 - Returns: `URL` The url to be used in Network module.
	 */
	func createGenreEndpoint() -> URL? {
		let endpoint = String(format: "https://api.themoviedb.org/3/genre/movie/list?api_key=%@&language=en-US", apiKey)
		
		let encodedEndpoint = self.encodeURL(endpoint)
		let endpointURL = URL(string: encodedEndpoint)
		
		return endpointURL
	}
	
	/**
	 Creates the image API endpoint.
	 - Parameter imagePath: String The path (/) and the filename of the requested image.
	 - Parameter type: Int Specifies whether the image is a movie poster or a backdrop.
	 - Returns: `URL` The url to be used in Network module.
	 */
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
	
	/// URL encodes the endpoint string to avoid illegal characters.
	private func encodeURL(_ urlString: String) -> String {
		if !urlString.isEmpty {
			if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
				return encodedString
			}
		}
		
		return ""
	}
}
