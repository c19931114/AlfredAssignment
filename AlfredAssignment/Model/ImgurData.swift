//
//  ImgurData.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

// https://api.imgur.com/models/basic
struct GallerySearchResult {
        
    var galleries: [Gallery]
    var success: Bool
    var status: Int
}

extension GallerySearchResult: Decodable {

    enum CodingKeys: String, CodingKey {
        case galleries = "data"
        case success
        case status
    }
}

struct Gallery {
        
    var id: String
    var title: String
    var cover: String?
    var coverWidth: Double?
    var coverHeight: Double?
    var link: String
    var datetime: Int
    var ups: Int
    var images: [GalleryImage]?
    var imagesCount: Int?
    var type: String?
    var isAlbum: Bool
    
    func getFirstImageLink() -> String? {
        guard isAlbum else {
            return type == "image/jpeg" ? link : nil
        }
        
        return images?.first(where: { image in
            image.type == "image/jpeg"
        })?.link
    }
}

extension Gallery: Hashable {
    static func == (lhs: Gallery, rhs: Gallery) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Gallery: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case cover
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case link
        case datetime
        case ups
        case images
        case imagesCount = "images_count"
        case type
        case isAlbum = "is_album"
    }
}

struct GalleryImage: Decodable {
    
    var id: String
    var title: String?
    var width: Double
    var height: Double
    var type: String
    var link: String
}

extension GalleryImage: Hashable {
    static func == (lhs: GalleryImage, rhs: GalleryImage) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
