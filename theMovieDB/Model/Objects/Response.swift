//
//  Response.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

struct Response: Codable {
	
	var page: Int
	var total_pages: Int
	var total_results: Int
	
	var results: [Movie]
}
