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
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    
    private func updateUI()
    {
        // load new photo
        if let imageURL = self.image?.url
        {
            // create the url path for small image
            let smallImageURLString = imageURL.absoluteString.replacingOccurrences(of: "_m.jpg", with: "_q.jpg")
            if let url = URL(string: smallImageURLString)
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
