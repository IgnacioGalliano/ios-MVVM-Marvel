//
//  GetCharacters.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

protocol GetCharacters {
    func execute(success: @escaping ([CharacterModel]) -> Void,
                 failure: @escaping (GetCharactersError) -> Void)
}

struct DefaultGetCharacters: GetCharacters {
    private let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository =  repository
    }

    func execute(success: @escaping ([CharacterModel]) -> Void,
                 failure: @escaping (GetCharactersError) -> Void) {
        repository.getCharacters { character in
            success(character)
        } failure: { error in
            failure(error)
        }
    }
}
