//
//  Utils.swift
//  Flickr
//
//  Created by Laura on 9/11/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func loadImage(withURL url: URL)
    {
        // load image in background
        DispatchQueue.global(qos: .userInitiated).async
            { [weak self] in
                if let data = try? Data(contentsOf: url)
                {
                    if let image = UIImage(data: data)
                    {
                        // switch to main thread
                        DispatchQueue.main.async
                            {
                                self?.image = image
                        }
                    }
                }
        }
    }
}
