//
//  ActionProvider.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

struct ActionProvider {
    static func getCharacters() -> GetCharacters {
        let repository = DataProvider.shared.getCharactersRepository()
        return DefaultGetCharacters(repository: repository)
    }

    static func getCharacterDetail() -> GetCharacterDetail {
        let repository = DataProvider.shared.getCharactersRepository()
        return DefaultGetCharacterDetail(repository: repository)
    }
}
