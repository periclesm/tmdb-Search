//
//  TableCellClass.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 25/3/22.
//

import UIKit

///Generic UITableViewCell with specific customization.
class GenericCell: UITableViewCell {
	override func awakeFromNib() {
		super.awakeFromNib()
		self.backgroundColor = UIColor.clear
	}
}

///Movie UITableViewCell subclassed from GenericCell to inherit all custom properties plus its own.
class MovieCell: UITableViewCell {
	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var movieTitle: UILabel!
	@IBOutlet weak var movieYear: UILabel!
	@IBOutlet weak var movieDetail: UILabel!
}
