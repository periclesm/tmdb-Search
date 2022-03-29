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
	
	@IBOutlet weak var backImage: UIImageView!
	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var movieSubtitle: UILabel!
	@IBOutlet weak var movieDescription: UILabel!
	@IBOutlet weak var movieRating: UILabel!
	@IBOutlet weak var movieVotes: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	//Assign the selected movie values into UI components.
	func setupUI() {
		self.movieTitle.text = vm.movie?.title
		self.movieSubtitle.text = vm.subtitleString()
		self.movieDescription.text = vm.movie?.overview
		self.movieRating.text = "\(vm.movie?.voteAverage ?? 0)"
		self.movieVotes.text = "\(vm.movie?.voteCount ?? 0) votes"
		self.backImage.getImage(url: vm.movie?.backdropPath, imageType: .backdrop)
		self.movieImage.getImage(url: vm.movie?.posterPath, imageType: .poster)
	}
}
