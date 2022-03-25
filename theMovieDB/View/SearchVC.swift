//
//  SearchVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVC: UITableViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "TMDB"
		self.navigationItem.titleView = searchBar

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}

extension SearchVC: UISearchBarDelegate {
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(true, animated: true)
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(false, animated: true)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		searchBar.text = ""
		debugPrint("Cancel Button Click")
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		debugPrint("Search Button Click")
		
		guard let searchTerm = searchBar.text else {
			return
		}
		
		if !searchTerm.isEmpty {
			debugPrint("Perform search too")
		}
	}
}
