//
//  TableCellController.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class TableCellController: NSObject {
	
	class func movieCell(for tableView: UITableView, datasource: Array<Any>, index: IndexPath) -> MovieCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: index) as! MovieCell
		let movie = datasource[index.row] as! Movie
		
		cell.movieTitle.text = movie.title
		cell.movieYear.text = MDDate.shared.convertDateFormat(inputString: movie.release_date, fromFormat: .original, toFormat: .short)
		cell.movieDetail.text = GenreController.getMovieGenres(movie)
		cell.movieImage.image = UIImage(named: "TMDB_poster")
		
		if let imagePath = movie.poster_path {
			DataManager().getImage(imagePath: imagePath) { image in
				UIView.transition(with: cell.movieImage, duration: 0.2, options: .transitionCrossDissolve) {
					cell.movieImage.image = image
				}
			}
		}
		
		return cell
	}
}
