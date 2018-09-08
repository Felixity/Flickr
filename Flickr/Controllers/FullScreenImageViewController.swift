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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
        if let image = self.image
        {
            self.spinner.startAnimating()
            // load photo in background
            DispatchQueue.global(qos: .userInitiated).async
                { [weak self] in
                    
                    guard let weakself = self else
                    { return }
                    
                    // create large image
                    let imageURLString = "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.id)_\(image.secret)_b.jpg"
                    if let imageURL = URL(string: imageURLString)
                    {
                        let urlContents = try? Data(contentsOf: imageURL)
                        if let imageData = urlContents
                        {
                            // switch to main thread
                            DispatchQueue.main.async
                                {
                                    weakself.spinner.stopAnimating()
                                    weakself.largeImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
            }
        }
    }
}
