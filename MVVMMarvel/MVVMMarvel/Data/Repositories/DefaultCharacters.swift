//
//  DefaultCharacters.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

protocol CharactersRepository {
    func getCharacters(success: @escaping ([CharacterModel]) -> Void,
                       failure: @escaping (GetCharactersError) -> Void)

    func getCharacterDetail(id: String,
                            success: @escaping (CharacterModel) -> Void,
                            failure: @escaping (GetCharactersError) -> Void)
}

class DefaultCharacters: CharactersRepository {
    private let configNetworkService: GetCharactersNetworkService
    private var character: [CharacterModel] = []

    init(configNetworkService: GetCharactersNetworkService) {
        self.configNetworkService = configNetworkService
    }

    func getCharacters(success: @escaping ([CharacterModel]) -> Void,
                       failure: @escaping (GetCharactersError) -> Void) {
        guard character.isEmpty else {
            success(character)
            return
        }

        fetchCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseDTO):
                self.character = responseDTO.data.results.compactMap({ $0.toCharacterModel() })
                success(self.character)
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getCharacterDetail(id: String,
                            success: @escaping (CharacterModel) -> Void,
                            failure: @escaping (GetCharactersError) -> Void) {
        fetchCharacters(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseDTO):
                self.character = responseDTO.data.results.compactMap({ $0.toCharacterModel() })
                if let character = self.character.first {
                    success(character)
                } else {
                    failure(.foundNil)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    private func fetchCharacters(id: String? = nil,
                                 completion: @escaping (Result<ResponseListDTO, GetCharactersError>)  -> Void) {
        configNetworkService.execute(id: id) { result in
            completion(result)
        }
    }
}

