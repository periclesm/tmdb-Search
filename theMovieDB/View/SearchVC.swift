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
	
	let vm = SearchVM()
	var backDelegate: BackgroundDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = ""
		self.navigationItem.titleView = searchBar
		self.tableView.backgroundView = backgroundView
		
		DataManager().getGenres()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "DetailSegue" {
			let dvc = segue.destination as! MovieVC
			if let object = sender as? Movie {
				dvc.vm.movie = object
			}
		}
		else if segue.identifier == "BackSegue" {
			let dvc = segue.destination as! BackVC
			self.backDelegate = dvc
		}
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		backDelegate?.displayContent(vm.movies.isEmpty)
		return vm.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return TableCellController.movieCell(for: tableView, datasource: vm.movies, index: indexPath)
    }
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
	//MARK: - Search functionality
	
	func clearSearch() {
		vm.clearData()
		self.tableView.reloadData()
	}
	
	func search(_ searchTerm: String) {
		vm.getSearchData(searchTerm: searchTerm) { completed in
			if completed {
				self.backDelegate?.displayMessage(self.vm.movies.isEmpty)
				debugPrint("[tvdb] Paginate: Page: \(self.vm.pageIndex) - Total Results: \(self.vm.totalCount) - Displaying: \(self.vm.movies.count)")
				self.tableView.reloadData()
			}
		}
	}
}

extension SearchVC: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
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
		self.clearSearch()
		
		guard let searchTerm = searchBar.text else {
			return
		}
		
		if !searchTerm.isEmpty {
			self.search(searchTerm)
		}
	}
}
