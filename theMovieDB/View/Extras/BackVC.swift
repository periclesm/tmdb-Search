//
//  BackVC.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 27/3/22.
//

import UIKit

struct ComicRelief {
	var message = ""
	var image = ""
}

protocol BackgroundDelegate {
	func displayMessage(_ display:Bool)
	func displayContent(_ display:Bool)
}

class BackVC: UIViewController {
	
	@IBOutlet weak var message: UILabel!
	@IBOutlet weak var content: UIStackView!
	
	enum buttonTags: Int {
		case trailers = 1, showtimes, boxoffice, topMovies, comingSoon, winners
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let dvc = segue.destination as! ContentVC
		dvc.content = sender as? ComicRelief
		
	}
    
	@IBAction func presentContentVC(_ sender: UIButton) {
		let tag = buttonTags(rawValue: sender.tag)
		self.performSegue(withIdentifier: "ComicSegue", sender: self.comic(tag: tag!))
	}
	
	private func comic(tag: buttonTags) -> ComicRelief {
		let comic: ComicRelief!
		
		switch tag {
		case .trailers:
			comic = ComicRelief.init(message: "You're gonna need a bigger app", image: "/s2xcqSFfT6F7ZXHxowjxfG0yisT.jpg")
			
		case .showtimes:
			comic = ComicRelief.init(message: "There's no place like search", image: "/bSA6DbAC5gdkaooU164lQUX6rVs.jpg")
			
		case .boxoffice:
			comic = ComicRelief.init(message: "My precious...", image: "/5VTN0pR8gcqV3EPUHHfMGnJYN9L.jpg")
			
		case .topMovies:
			comic = ComicRelief.init(message: "Search, my dear Watson", image: "/eFORQaQuldP89f8mQMaa71mmLqu.jpg")
			
		case .comingSoon:
			comic = ComicRelief.init(message: "May the Search be with you", image: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg")
			
		case .winners:
			comic = ComicRelief.init(message: "Search. James Search", image: "/w9ph5cUfGbw41WXt7yuXsWeN2TV.jpg")
		}
		
		return comic
	}
}

extension BackVC: BackgroundDelegate {
	func displayMessage(_ display: Bool) {
		self.message.isHidden = !display
	}
	
	func displayContent(_ display: Bool) {
		self.content.isHidden = !display
	}
}
