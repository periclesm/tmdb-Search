//
//  TableCellController.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

class TableCellController: NSObject {
	
	class func movieCell(for tableView: UITableView, datasource: Array<Any>, index: IndexPath) -> movieCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: index) as! movieCell
		let movie = datasource[index.row] as! Movie
		
		cell.movieTitle.text = movie.title
		cell.movieYear.text = movie.release_date
		cell.movieDetail.text = movie.overview
		
		if let imagePath = movie.poster_path {
			DataManager().getImage(imagePath: imagePath) { image in
				cell.movieImage.image = image
			}
		}
		
		return cell
	}
}
