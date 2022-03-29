//
//  TableCellController.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class TableCellController: NSObject {
	
	///Function to create the movie UITableViewCell and assign values to the respective UI components.
	class func movieCell(for tableView: UITableView, dataObject: Movie, index: IndexPath) -> MovieCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: index) as! MovieCell
		
		cell.movieTitle.text = dataObject.title
		cell.movieYear.text = MDDate.shared.convertDateFormat(inputString: dataObject.releaseDate, fromFormat: .original, toFormat: .short)
		cell.movieDetail.text = GenreController.getMovieGenres(dataObject)
		cell.movieImage.getImage(url: dataObject.posterPath, imageType: .poster, placeholder: UIImage(named: "TMDB_poster"))
		
		return cell
	}
}
