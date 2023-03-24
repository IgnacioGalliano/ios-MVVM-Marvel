//
//  CharacterDTO.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailDTO

    func toCharacterModel() -> CharacterModel {
        return CharacterModel(id: id,
                              name: name,
                              description: description,
                              thumbnail: thumbnail.toThumbnail())
    }
}
