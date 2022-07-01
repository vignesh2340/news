//
//  MostPapularModel.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import Foundation

struct MostPapularNews: Decodable {
    var results: [PapularNews]?
}


struct PapularNews: Decodable {
    
    var url: String?
    var id: Int?
    var title: String?
    var abstract: String?
    var media: [NewsMedia]?
    var updated: String?
    
}

struct NewsMedia: Decodable {
    
    var type: MediaType?
    var mediaMetaData: [MediaMetaData]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case media = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(MediaType.self, forKey: .type)
        mediaMetaData = try values.decodeIfPresent([MediaMetaData].self, forKey: .media)
    }
    
}

struct MediaMetaData: Decodable {
    var url: String?
    var format: MediaFormat?
}


enum MediaType: String, Decodable {
    case image
}

enum MediaFormat: String, Decodable {
    case standard = "Standard Thumbnail"
    case medium210 = "mediumThreeByTwo210"
    case medium440 = "mediumThreeByTwo440"
}
