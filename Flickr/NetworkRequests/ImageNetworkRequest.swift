//
//  ImageNetworkRequest.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import Foundation

fileprivate let apiKey = "675894853ae8ec6c242fa4c077bcf4a0"
fileprivate let fullURLPath = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text={text}&extras=url_s&format=json&nojsoncallback=1&per_page={perPage}&page={page}"
fileprivate let textSubstring = "{text}"
fileprivate let perPageSubstring = "{perPage}"
fileprivate let pageSubstring = "{page}"

class ImageNetworkRequest
{
    private var _sharedInstance: ImageNetworkRequest?
    var sharedInstance: ImageNetworkRequest
    {
        get
        {
            if _sharedInstance == nil
            {
                _sharedInstance = ImageNetworkRequest()
            }
            return _sharedInstance!
        }
    }
    
    static private var fullPath = ""
    
    private class func getFullURL(searchedText: String, perPage: Int, page: Int) -> String
    {
        fullPath = fullURLPath.replacingOccurrences(of: textSubstring, with: "\(searchedText)")
        fullPath = fullPath.replacingOccurrences(of: perPageSubstring, with: "\(perPage)")
        fullPath = fullPath.replacingOccurrences(of: pageSubstring, with: "\(page)")
        
        print(fullPath)
        
        return fullPath
    }
 
    class func searchImages(forText text: String, perPage: Int, page: Int, successCallBack: @escaping ([Image]) -> (), errorCallBack: ((Error?) -> ())?)
    {
        let urlString = getFullURL(searchedText: text, perPage: perPage, page: page)
        if let url = URL(string: urlString)
        {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(with: request)
            { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error
                {
                    errorCallBack?(error)
                }
                else if let data = data
                {
                    if let searchPhotoResponse = try? JSONDecoder().decode(SearchImageResponse.self, from: data)
                    {
                        successCallBack(searchPhotoResponse.photos)
                    }
                    else
                    {
                        print("error")
                    }
                }
            }
            task.resume()
        }
    }

}
