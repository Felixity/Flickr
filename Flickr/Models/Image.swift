//
//  Image.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import Foundation

class Image: NSObject, Decodable
{
    var id: String          = ""
    var owner: String       = ""
    var secret: String      = ""
    var server: String      = ""
    var farm: Int           = 0
    var title: String       = ""
    var isPublic: Bool      = false
    var isFriend: Bool      = false
    var isFamily: Bool      = false
    var url: URL?           = nil
    var height: String?     = nil
    var width: String?      = nil
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case isPublic   = "ispublic"
        case isFriend   = "isfriend"
        case isFamily   = "isfamily"
        case url        = "url_s"
        case height     = "height_s"
        case width      = "width_s"
    }
        
    override init()
    {
    }
    
    // decoding model from JSON
    convenience required init(from decoder: Decoder) throws
    {
        self.init()
        let photoValues = try decoder.container(keyedBy: CodingKeys.self)
        id          = try photoValues.decode(String.self, forKey: .id)
        owner       = try photoValues.decode(String.self, forKey: .owner)
        secret      = try photoValues.decode(String.self, forKey: .secret)
        server      = try photoValues.decode(String.self, forKey: .server)
        farm        = try photoValues.decode(Int.self, forKey: .farm)
        title       = try photoValues.decode(String.self, forKey: .title)
        isPublic    = (try photoValues.decode(Int.self, forKey: .isPublic) == 1) ? true : false
        isFriend    = (try photoValues.decode(Int.self, forKey: .isFriend) == 1) ? true : false
        isFamily    = (try photoValues.decode(Int.self, forKey: .isFamily) == 1) ? true : false
        url         = try photoValues.decodeIfPresent(URL.self, forKey: .url)
        height      = try photoValues.decodeIfPresent(String.self, forKey: .height)
        width       = try photoValues.decodeIfPresent(String.self, forKey: .width)
    }
    
}
