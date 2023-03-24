//
//  CharactersListViewModel.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

protocol CharactersListViewModelable {
    var getQuantityOfCharacters: Int { get }
    var view: CharactersListView? { get set }

    func loadCharacters()
    func getCharacters(indexPath: IndexPath) -> CharacterModel
    func cellPressed(indexPath: IndexPath)
}

class CharactersListViewModel: CharactersListViewModelable {
    private let getCharacters: GetCharacters
    private var characterList: [CharacterModel] = []
    private let coordinator: CharactersListCoordinatable
    weak var view: CharactersListView?

    var getQuantityOfCharacters: Int {
        return characterList.count
    }

    init(getCharacters: GetCharacters = ActionProvider.getCharacters(),
         coordinator: CharactersListCoordinatable) {
        self.getCharacters = getCharacters
        self.coordinator = coordinator
    }

    func loadCharacters() {
        view?.showLoanding()
        getCharacters.execute { [weak self] characterList in
            guard let self = self else { return }
            self.characterList = characterList
            if characterList.isEmpty {
                self.view?.showError(message: Localizable.placeholderText)
            } else {
                self.view?.reloadData()
                self.view?.dismissLoading()
            }
        } failure: { error in
            self.view?.dismissLoading()
            self.view?.showError(message: Localizable.errorLoadingData)
        }
    }

    func getCharacters(indexPath: IndexPath) -> CharacterModel {
        characterList[indexPath.row]
    }

    func cellPressed(indexPath: IndexPath) {
        let character = characterList[indexPath.row]
        coordinator.openDetail(character: character)
    }
}
