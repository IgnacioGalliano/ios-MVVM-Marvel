//
//  ThumbnailDTO.swift
//  MVVMMarvel
//
//  Created by Nacho on 07/03/2022.
//

import Foundation

struct ThumbnailDTO: Decodable {
    let path: String
    let imageExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }

    func toThumbnail() -> Thumbnail {
        return Thumbnail(path: path,
                         imageExtension: imageExtension)
    }
}
