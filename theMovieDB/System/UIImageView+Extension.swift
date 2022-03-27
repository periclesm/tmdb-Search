//
//  UIImageView+Extension.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 26/3/22.
//

import UIKit

extension UIImageView {
	
	func getImage(url: String?, imageType: ImageType, placeholder: UIImage? = nil) {
		if placeholder != nil {
			self.image = placeholder
		}
		
		if let urlString = url {
			DataManager().getImage(imagePath: urlString, type: imageType) { image in
				if image != nil {
					self.swapImage(new: image)
				}
			}
		}
	}
	
	func swapImage(new: UIImage?) {
		guard let newImage = new else {
			return
		}
		
		UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
			self.image = newImage
		}
	}
}
