//
//  SearchVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVC: UITableViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var backgroundView: UIView!
	
	///Initialize the View Model
	let vm = SearchVM()
	
	///Define the background delegate (to display/hide messages and actions when there are no search results)
	var backDelegate: BackgroundDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = ""
		self.navigationItem.titleView = searchBar
		self.tableView.backgroundView = backgroundView
		
		//Fetch all Genres and store them
		DataManager().getGenres()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "DetailSegue" {
			let dvc = segue.destination as! MovieVC
			if let object = sender as? Movie {
				//Send the selected movie to the (by now initialized) MovieVM object
				dvc.vm.movie = object
			}
		}
		else if segue.identifier == "BackSegue" {
			let dvc = segue.destination as! BackVC
			//Define the Background Delegate
			self.backDelegate = dvc
		}
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//Show/hide backgound depending on the UITableView array count.
		backDelegate?.displayContent(vm.movies.isEmpty)
		return vm.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let movie = vm.movies[indexPath.row]
		return TableCellController.movieCell(for: tableView, dataObject: movie, index: indexPath)
    }
	
	// MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		/*
		 When preparing to display the cell, make certain checks and fetch the next results page.
		 IF <cell is the last in table> AND <total tableview data is less than total search results> THEN <increment page by one> AND fetch next page data
		 New data will be parsed and appended in DataManager and (upon completion) table view will reload data.
		 */
		
		if (indexPath.row+1 == vm.movies.count) && (vm.movies.count < vm.totalCount) {
			vm.pageIncrement()
			self.search(searchBar.text!)
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let movie = vm.movies[indexPath.row]
		self.performSegue(withIdentifier: "DetailSegue", sender: movie)
	}
    
	//MARK: - Search methods
	
	///Clear search data method.
	func clearSearch() {
		vm.clearData()
		self.tableView.reloadData()
	}
	
	///Asks the View Model to fetch data. Upon completion, it performs a check if data empty and reloads table.
	func search(_ searchTerm: String) {
		vm.getSearchData(searchTerm: searchTerm) { completed in
			if completed {
				self.backDelegate?.displayMessage(self.vm.movies.isEmpty)
				debugPrint("[tvdb-SearchVC] Paginate: Page: \(self.vm.pageIndex) - Total Results: \(self.vm.totalCount) - Displaying: \(self.vm.movies.count)")
				self.tableView.reloadData()
			}
		}
	}
}

extension SearchVC: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			//clear all data when user deletes all characters with backspace.
			self.clearSearch()
		}
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(true, animated: true)
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(false, animated: true)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		
		//Clear all previous data for a fresh search.
		self.clearSearch()
		
		//If, for any reason, there is no search term, stop eveything.
		guard let searchTerm = searchBar.text else {
			return
		}
		
		//If the search term is not an empty string, proceed.
		if !searchTerm.isEmpty {
			self.search(searchTerm)
		}
		
		//Remember: There's a difference between nil and empty.
	}
}
