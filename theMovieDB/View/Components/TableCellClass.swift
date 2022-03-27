//
//  TableCellClass.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit


class GenericCell: UITableViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()
		//self.backgroundColor = UIColor.clear
	}
}

class MovieCell: GenericCell {
	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var movieYear: UILabel!
	@IBOutlet weak var movieDetail: UILabel!
}
