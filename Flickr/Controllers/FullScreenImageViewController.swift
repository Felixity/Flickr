//
//  FullScreenImageViewController.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController
{
    //MARK: - Outlets -
    @IBOutlet weak var largeImageView: UIImageView!
    
    //MARK: - Public variables -
    var image: Image?
    
    //MARK: - ViewController Life cyle Methods -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loadLargeImage()
    }
    
    class func getIdentifier() -> String
    {
        return String(describing: self)
    }
    
    class func loadFromNib() -> FullScreenImageViewController?
    {
        let storyboardName = "Main"
        let className = self.getIdentifier()
        let fullScreenImageStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        guard let fullScreenImageViewController = fullScreenImageStoryboard.instantiateViewController(withIdentifier: className) as? FullScreenImageViewController else
        {
            assertionFailure("Unable to load FullScreenImageViewController!!")
            return nil
        }
        
        return fullScreenImageViewController
    }
    
    private func loadLargeImage()
    {
        if let imageURL = self.image?.url
        {
            // create the url path for large image
            let largeImageURLString = imageURL.absoluteString.replacingOccurrences(of: "_m.jpg", with: "_b.jpg")
            if let url = URL(string: largeImageURLString)
            {
                self.largeImageView.loadImage(withURL: url)
            }
        }
    }
}
