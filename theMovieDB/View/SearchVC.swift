//
//  SearchVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class SearchVC: UITableViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	
	let vm = SearchVM()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "TMDB"
		self.navigationItem.titleView = searchBar
		
		DataManager().getGenres()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "DetailSegue" {
			let dvc = segue.destination as! MovieVC
			if let object = sender as? Movie {
				dvc.vm.movie = object
			}
		}
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return vm.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return TableCellController.movieCell(for: tableView, datasource: vm.movies, index: indexPath)
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
	
	@IBAction func refreshSearch() {
		if let searchTerm = searchBar.text {
			vm.getSearchData(searchTerm: searchTerm) { completed in
				self.tableView.refreshControl?.endRefreshing()
				if completed {
					self.tableView.reloadData()
				}
			}
		}
		else {
			self.tableView.refreshControl?.endRefreshing()
		}
	}
	
	func search(_ searchTerm: String) {
		self.tableView.refreshControl?.beginRefreshing()
		
		vm.getSearchData(searchTerm: searchTerm) { completed in
			self.tableView.refreshControl?.endRefreshing()
			if completed {
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
		searchBar.text = ""
		self.clearSearch()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		
		guard let searchTerm = searchBar.text else {
			return
		}
		
		if !searchTerm.isEmpty {
			self.search(searchTerm)
		}
	}
}
