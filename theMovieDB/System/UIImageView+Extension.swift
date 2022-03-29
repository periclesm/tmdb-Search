//
//  UIImageView+Extension.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 26/3/22.
//

import UIKit

extension UIImageView {
	
	/**
	 Extending UIImageView to simplify fetching an image from the internet and animating a transition between the previous view state into the new.
	 - Parameter url: String The payload image string to be constructed in `DataAPI`
	 - Parameter imagetype: ImageType The image type to determine whether the image is a poster or a backdrop.
	 - Parameter placeholder: UIImage (optional) Show a placeholder image while fetching the actual image data.
	 */
	func getImage(url: String?, imageType: ImageType, placeholder: UIImage? = nil) {
		
		//If the placeholder is not nil, place it in the UIImageView while fetching the image data.
		//If nil, leave UIImageView as is.
		if placeholder != nil {
			self.image = placeholder
		}
		
		//Check the image string and fetch the image data from the internet.
		if let urlString = url {
			DataManager().getImage(imagePath: urlString, type: imageType) { image in
				if image != nil {
					//Animate a transition between the previous UIImageView image and the new.
					self.swapImage(newImage: image)
				}
			}
		}
	}
	
	/**
	 Extending UIImageView to provide a transition between the previous view state into the new.
	 - Parameter newImage: UIImage The payload image string to be constructed in `DataAPI`
	 */
	func swapImage(newImage: UIImage?) {
		guard let newImage = newImage else {
			return
		}
		
		UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve) {
			self.image = newImage
		}
	}
}
