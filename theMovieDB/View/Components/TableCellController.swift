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
		cell.movieDetail.text = GenreController.getMovieGenres(movie) //movie.overview
		cell.movieImage.image = nil
		
		if let imagePath = movie.poster_path {
			DataManager().getImage(imagePath: imagePath) { image in
				cell.movieImage.image = image
			}
		}
		
		return cell
	}
}
