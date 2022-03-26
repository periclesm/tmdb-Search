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
	var imageEndpointURL = DataAPI().createImageEndpoint(imagePath: "")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testEndpoint() throws {
		debugPrint("+++ API Tests")
		XCTAssertNotNil(searchEndpointURL)
		XCTAssertNotNil(genreEndpointURL)
		XCTAssertNotNil(imageEndpointURL)
	}
	
	func testAPI() throws {
		var responseData: Data?
		let operationWait = expectation(description: "Fetching API Data")
		
		if searchEndpointURL == nil {
			XCTAssertNotNil(searchEndpointURL)
		}
		
		Network().getData(endpoint: searchEndpointURL!) { data, error in
			XCTAssertTrue((error != nil), "API Network call completion")
			responseData = data
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNotNil(responseData)
		
	}
	
	func testAPIFailed() throws {
		
	}

}
