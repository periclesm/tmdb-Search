//
//  Network.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import Foundation

enum NetHTTPMethod: String {
	case GET = "GET"
	case POST = "POST"
}

class Network: NSObject {

	///Creates a URLSession request with a predefined set of parameters.
	func createRequest(url: URL, method: NetHTTPMethod = .GET, caching: URLRequest.CachePolicy = .useProtocolCachePolicy) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 15
		request.httpMethod = method.rawValue
		request.cachePolicy = caching
		request.httpShouldUsePipelining = true
		request.allowsCellularAccess = true
		
		return request
	}
	
	/**
	 The main Network function to fetch data from the internet.
	 - Parameter endPoint: URL The URL the method will use to fetch data.
	 - Returns: `Data` An object containing the raw data received for further process (ex. if JSON -- parse and store, if image -- convert and return)
	 - Returns: `Error` in case of error, an object describing the reasons and codes of the error and why it occured.
	 */
	func getData(endpoint: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
		let request = self.createRequest(url: endpoint)
		let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
		let task = session.dataTask(with: request) { data, response, error in
			if error != nil {
				completion(nil, error)
			}
			else {
				completion(data, nil)
			}
		}
		
		task.resume()
		session.finishTasksAndInvalidate()
	}
}

extension Network: URLSessionDelegate {
	
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		//debugPrint("finished task")
	}
	
	func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
		//debugPrint("invalidated with reason: \(String(describing: error?.localizedDescription))")
		if error != nil {
			assert(true, "Error: \(error?.localizedDescription ?? "")")
		}
	}
}
