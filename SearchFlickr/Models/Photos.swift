//
//  Photos.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/29/23.
//

import Foundation

/**
 NOTE:  I combined two models int his file for simplicity.  Splitting Item out into its own file is an option if needed.
 */

struct Photos: Decodable {
    var title: String
    var link: String
    var description: String
    var modified: Date
    var generator: String
    var items: [Item]
}

struct Item: Decodable {
    var title: String
    var link: String
    var photoUrl: String
    var dateTaken: Date
    var description: String
    var published: Date
    var author: String
    var authorId: String
    var tags: String
    
    enum CodingKeys: CodingKey {
        case title
        case link
        case dateTaken
        case description
        case published
        case author
        case authorId
        case tags
        case media
    }
    
    private enum MediaCodingKeys: String, CodingKey {
        case m
    }
    
    // Use CodingKeys to flatten nested container
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)

        // Root level
        self.title = try rootContainer.decode(String.self, forKey: .title)
        self.link = try rootContainer.decode(String.self, forKey: .link)
        self.dateTaken = try rootContainer.decode(Date.self, forKey: .dateTaken)
        self.description = try rootContainer.decode(String.self, forKey: .description)
        self.published = try rootContainer.decode(Date.self, forKey: .published)
        self.author = try rootContainer.decode(String.self, forKey: .author)
        self.authorId = try rootContainer.decode(String.self, forKey: .authorId)
        self.tags = try rootContainer.decode(String.self, forKey: .tags)

        // media contains a property called m that contains the url to the photo
        let media = try rootContainer.nestedContainer(keyedBy: MediaCodingKeys.self, forKey: CodingKeys.media)
        self.photoUrl = try media.decode(String.self, forKey: .m)
    }
    
}
