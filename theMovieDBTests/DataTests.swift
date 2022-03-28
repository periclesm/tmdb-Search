//
//  DataTests.swift
//  theMovieDBTests
//
//  Created by Perikles Maravelakis on 26/3/22.
//

import XCTest
@testable import theMovieDB

class DataTests: XCTestCase {

	var timeout = 15
	var searchTerm = "matrix"
	
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
	
	func testDataPagination() throws {
		let searchVM = SearchVM()
		var storedDataCount = searchVM.movies.count
		DataStore.shared.totalResults = 1 //used to kickstart the while loop below
		
		while searchVM.movies.count < searchVM.totalCount {
			let operationWait = expectation(description: "Fetching API Data")
			searchVM.getSearchData(searchTerm: searchTerm) { completed in
				XCTAssertTrue(completed)
				operationWait.fulfill()
			}
			
			waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
			
			if storedDataCount != searchVM.movies.count {
				XCTAssertTrue(true)
				storedDataCount = searchVM.movies.count
				debugPrint("[tmdb-UT] Stored count: \(storedDataCount) of \(searchVM.totalCount)")
			}
			else {
				XCTAssertTrue(false, "Failed in page \(searchVM.pageIndex)")
			}
			
			searchVM.pageIndex+=1
		}
	}
}
