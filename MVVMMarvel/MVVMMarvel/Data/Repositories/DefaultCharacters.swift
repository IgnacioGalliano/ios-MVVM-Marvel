//
//  DefaultCharacters.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

protocol CharactersRepository {
    func getCharacters(success: @escaping ([CharacterModel]) -> Void,
                       failure: @escaping ([Error]) -> Void)

    func getCharacterDetail(id: String,
                            success: @escaping (CharacterModel) -> Void,
                            failure: @escaping ([Error]) -> Void)
}

class DefaultCharacters: CharactersRepository {
    private let configNetworkService: GetMoviesNetworkService
    private var character: [CharacterModel] = []

    init(configNetworkService: GetMoviesNetworkService) {
        self.configNetworkService = configNetworkService
    }

    func getCharacters(success: @escaping ([CharacterModel]) -> Void,
                       failure: @escaping ([Error]) -> Void) {
        guard character.isEmpty else {
            success(character)
            return
        }

        fetchMovies { [weak self] result in
            guard let self = self else { return }
            self.character = result.data.results.compactMap({ $0.toCharacterModel() })
            success(self.character)
        } failure: { error in
            failure(error)
        }
    }

    func getCharacterDetail(id: String,
                            success: @escaping (CharacterModel) -> Void,
                            failure: @escaping ([Error]) -> Void) {
        fetchMovies(id: id) { [weak self] result in
            guard let self = self else { return }
            self.character = result.data.results.compactMap({ $0.toCharacterModel() })
            if let character = self.character.first {
                success(character)
            } else {
                failure([NSError(domain: "Error", code: 404, userInfo: nil)])
            }
        } failure: { error in
            failure(error)
        }
    }

    private func fetchMovies(id: String? = nil,
                             success: @escaping (ResponseListDTO) -> Void,
                             failure: @escaping ([Error]) -> Void) {
        configNetworkService.execute(id: id) { result in
            success(result)
        } failure: { error in
            failure(error)
        }
    }
}

