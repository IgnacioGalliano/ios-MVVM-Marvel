//
//  DataProvider.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

class DataProvider {
    static let shared = DataProvider()

    private lazy var charactersRepository: DefaultCharacters = {
        return DefaultCharacters(configNetworkService: getCharactersNetworkService())
    }()

    func getCharactersNetworkService() -> DefaultGetCharactersNetworkService {
        DefaultGetCharactersNetworkService()
    }

    func getCharactersRepository() -> CharactersRepository {
        return charactersRepository
    }
}
