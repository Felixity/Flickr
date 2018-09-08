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
            // load photo in background
            DispatchQueue.global(qos: .userInitiated).async
                { [weak self] in
                    
                    guard let weakself = self else
                    { return }
                    
                    // create the url path for the small image
                    let imageURLString = "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.id)_\(image.secret)_q.jpg"
                    let imageURL = URL(string: imageURLString)
                    
                    let urlContents = try? Data(contentsOf: imageURL!)
                    if let imageData = urlContents
                    {
                        // switch to main thread
                        DispatchQueue.main.async
                            {
                                weakself.photoImageView.image = UIImage(data: imageData)
                        }
                    }
            }
        }
    }
    
    class func getIdentifier() -> String
    {
        return String(describing: self)
    }
}
