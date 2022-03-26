//
//  MovieVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

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
	
	func setupUI() {
		self.movieTitle.text = vm.movie?.title
		self.movieSubtitle.text = "\(MDDate.shared.convertDateFormat(inputString: vm.movie?.release_date, fromFormat: .original, toFormat: .formatted)) • \(GenreController.getMovieGenres(vm.movie))"
		self.movieDescription.text = vm.movie?.overview
		self.movieRating.text = "\(vm.movie?.vote_average ?? 0)"
		self.movieVotes.text = "\(vm.movie?.vote_count ?? 0) votes"
		self.backImage.getImage(url: vm.movie?.backdrop_path)
		self.movieImage.getImage(url: vm.movie?.poster_path)
	}
}
