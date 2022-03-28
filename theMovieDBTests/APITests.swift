//
//  APITests.swift
//  theMovieDBTests
//
//  Created by Perikles Maravelakis on 26/3/22.
//

import XCTest
@testable import theMovieDB

class APITests: XCTestCase {
	
	var timeout = 15
	var searchEndpointURL = DataAPI().createMovieEndoint(searchTerm: "aliens")
	var genreEndpointURL = DataAPI().createGenreEndpoint()
	var imageEndpointURL = DataAPI().createImageEndpoint(imagePath: "/8c4a8kE7PizaGQQnditMmI1xbRp.jpg")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testSearchAPI() throws {
		XCTAssertNotNil(searchEndpointURL)
		
		var responseData: Data?
		let operationWait = expectation(description: "Fetching Search API Data")
		
		Network().getData(endpoint: searchEndpointURL!) { data, error in
			if error != nil {
				XCTAssertTrue(false, "Search API Network call error") //I want this to fail...
			}
			
			responseData = data
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNotNil(responseData)
		
		//map data
		let parsedData: Search = DataManager().parseData(data: responseData!)
		XCTAssertNotNil(parsedData)
	}
	
	func testGenresAPI() throws {
		XCTAssertNotNil(genreEndpointURL)
		
		var responseData: Data?
		let operationWait = expectation(description: "Fetching Genres API Data")
		
		Network().getData(endpoint: genreEndpointURL!) { data, error in
			if error != nil {
				XCTAssertTrue(false, "Genres API Network error") // ... in order to determine the error ...
			}
			
			responseData = data
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNotNil(responseData)
		
		//map data
		let parsedData: GenreResponse = DataManager().parseData(data: responseData!)
		XCTAssertNotNil(parsedData)
	}
	
	func testImageAPI() throws {
		XCTAssertNotNil(imageEndpointURL)
		
		let operationWait = expectation(description: "Fetching Image API Data")
		var image: UIImage?
		
		Network().getData(endpoint: imageEndpointURL!) { data, error in
			if error != nil {
				XCTAssertTrue(false, "Images API Network error") // ... and display/process/handle it.
			}
			
			image = UIImage(data: data!)
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNotNil(image)
	}
	
	func testBlankImageAPI() {
		// Setting first a blank image
		let blankImageEndpointURL = DataAPI().createImageEndpoint(imagePath: "")
		XCTAssertNotNil(blankImageEndpointURL)
		
		let operationWait = expectation(description: "Fetching Blank Image API Data")
		var image: UIImage?
		
		Network().getData(endpoint: blankImageEndpointURL!) { data, error in
			image = UIImage(data: data!)
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNil(image)
	}
}
