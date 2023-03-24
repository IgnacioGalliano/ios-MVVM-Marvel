//
//  CharactersListCoordinator.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

protocol CharactersListCoordinatable {
    func openDetail(character: CharacterModel)
}

class CharactersListCoordinator: CharactersListCoordinatable {
    weak var view: CharactersListView?

    func openDetail(character: CharacterModel) {
        let detailViewController = CharacterDetailBuilder.build(characterId: character.id)
        view?.pushController(controller: detailViewController)
    }
}
