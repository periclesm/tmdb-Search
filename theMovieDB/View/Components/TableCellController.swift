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
		
		cell.movieTitle.text = "Terminator"
		cell.movieYear.text = "1992"
		cell.movieDetail.text = "Lorem Ipsum"
		
		if let imagePath = movie.poster_path {
			DataManager().getImage(imagePath: imagePath) { image in
				cell.movieImage.image = image
			}
		}
		
		return cell
	}
}
