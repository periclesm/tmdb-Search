//
//  ImageManager.swift
//  theMovieDB
//
//  Created by Perikles Maravelakis on 21/9/22.
//

import Foundation
import Kingfisher

/**
 A wrapper with default options for Kingfisher image downloader.
 */

class ImageManager: NSObject {
	
	class func fetchImage(imageFile: String?, imageView: UIImageView, type: ImageType? = .poster, placeholder: UIImage? = nil) {
		guard let imageFile else {
			imageView.image = placeholder
			return
		}
		
		let imageURL = DataAPI().createImageEndpoint(imagePath: imageFile, type: type)
		
		if let imageURL {
			let options: KingfisherOptionsInfo = [.onFailureImage(placeholder), .scaleFactor(UIScreen.main.scale)]
			
			imageView.kf.indicatorType = .activity
			imageView.kf.setImage(with: imageURL, options: options, completionHandler:  { result in
				switch result {
				case .failure(let error):
					debugPrint("[Kingfish] Image Fetch Failed: \(error.localizedDescription)")
					imageView.image = placeholder
					
				default: break
				}
			})
		}
		else {
			imageView.image = placeholder
		}
	}
}
