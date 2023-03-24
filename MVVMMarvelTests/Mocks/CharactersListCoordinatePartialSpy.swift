//
//  CharactersListCoordinatePartialSpy.swift
//  MVVMMarvelTests
//
//  Created by Nacho on 09/03/2022.
//

@testable import MVVMMarvel

class CharactersListCoordinatePartialSpy: CharactersListCoordinatable {
    var invokedOpenDetail = false
    var invokedOpenDetailCount = 0
    var invokedOpenDetailParameters: (character: CharacterModel, Void)?
    var invokedOpenDetailParametersList = [(character: CharacterModel, Void)]()

    func openDetail(character: CharacterModel) {
        invokedOpenDetail = true
        invokedOpenDetailCount += 1
        invokedOpenDetailParameters = (character, ())
        invokedOpenDetailParametersList.append((character, ()))
    }
}
