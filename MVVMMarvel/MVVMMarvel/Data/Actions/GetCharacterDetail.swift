//
//  GetCharacterDetail.swift
//  MVVMMarvel
//
//  Created by Nacho on 07/03/2022.
//

import Foundation

protocol GetCharacterDetail {
    func execute(id: String,
                 success: @escaping (CharacterModel) -> Void,
                 failure: @escaping (GetCharactersError) -> Void)
}

struct DefaultGetCharacterDetail: GetCharacterDetail {
    private let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository =  repository
    }

    func execute(id: String,
                 success: @escaping (CharacterModel) -> Void,
                 failure: @escaping (GetCharactersError) -> Void) {
        repository.getCharacterDetail(id: id) { character in
            success(character)
        } failure: { error in
            failure(error)
        }
    }
}
