//
//  SearchImageResponse.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import Foundation

class SearchImageResponse: NSObject, Decodable
{
    var page: Int       = 0
    var pages: Int      = 0
    var perPage: Int    = 0
    var total: String   = ""
    var photos: [Image] = []
    var stat: String?   = nil
    
    enum PhotoKeys: String, CodingKey
    {
        case photos
    }
    
    enum SearchPhotoKeys: String, CodingKey
    {
        case page
        case pages
        case perPage    = "perpage"
        case total
        case photos     = "photo"
        case stat
    }
    
    override init()
    {
    }
    
    // decoding model from JSON
    convenience required init(from decoder: Decoder) throws
    {
        self.init()
        let searchPhotoValues = try decoder.container(keyedBy: PhotoKeys.self)
        let photoValues = try searchPhotoValues.nestedContainer(keyedBy: SearchPhotoKeys.self, forKey: .photos)
        page    = try photoValues.decode(Int.self, forKey: .page)
        pages   = try photoValues.decode(Int.self, forKey: .pages)
        perPage = try photoValues.decode(Int.self, forKey: .perPage)
        total   = try photoValues.decode(String.self, forKey: .total)
        photos  = try photoValues.decode([Image].self, forKey: .photos)
        stat    = try photoValues.decodeIfPresent(String.self, forKey: .stat)
    }
}
