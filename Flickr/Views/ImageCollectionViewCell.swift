//
//  ImageCollectionViewCell.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var photoImageView: UIImageView!
    
    var image: Image?
    {
        didSet
        {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        // reset any existing informaiton
        self.photoImageView.image = nil
        
        // load new photo
        if let image = self.image
        {
            // create the url path for small image
            let imageURLString = "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.id)_\(image.secret)_q.jpg"
            if let url = URL(string: imageURLString)
            {
                self.photoImageView.loadImage(withURL: url)
            }
        }
    }
    
    class func getIdentifier() -> String
    {
        return String(describing: self)
    }
}
