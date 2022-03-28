//
//  ContentVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 27/3/22.
//

import UIKit

class ContentVC: UIViewController {
	
	var content: ComicRelief?
	
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var message: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		message.text = content?.message
		image.getImage(url: content?.image, imageType: .poster)
	}
	
}
