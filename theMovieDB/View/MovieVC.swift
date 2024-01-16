//
//  MovieVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

/**
 This is a straightforward VC, used only to display the movie information.
 No further actions or user input is needed.
 */
class MovieVC: UITableViewController {
	
	let vm = MovieVM()
	
	@IBOutlet weak var background: UIView!
	@IBOutlet weak var backgroundImage: UIImageView!
	
	@IBOutlet weak var backImage: UIImageView!
	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var movieGenres: UILabel!
	@IBOutlet weak var movieReleaseDate: UILabel!
	@IBOutlet weak var movieDescription: UILabel!
	@IBOutlet weak var movieRatings: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.backgroundView = background
		setupUI()
    }
	
	//Assign the selected movie values into UI components.
	func setupUI() {
		movieTitle.text = vm.movie?.title
		movieGenres.text = vm.genresString()
		movieReleaseDate.text = vm.releaseDateString()
		movieDescription.text = vm.movie?.overview
		movieRatings.text = vm.ratingsString()
		
		ImageManager.fetchImage(imageFile: vm.movie?.backdropPath, imageView: backImage, type: .backdrop)
		ImageManager.fetchImage(imageFile: vm.movie?.posterPath, imageView: movieImage)
		ImageManager.fetchImage(imageFile: vm.movie?.posterPath, imageView: backgroundImage)
	}
}
