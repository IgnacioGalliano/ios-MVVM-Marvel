//
//  CharacterDetailViewModel.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

protocol CharacterDetailViewModelable {
    var view: CharacterDetailView? { get set }
    var imagePresentationURL: String? { get }
    var title: String? { get }
    var description: String? { get }

    func loadCharacter()
}

class CharacterDetailViewModel: CharacterDetailViewModelable {
    private let getCharacterDetail: GetCharacterDetail
    private let characterId: Int
    private var character: CharacterModel?
    weak var view: CharacterDetailView?

    var imagePresentationURL: String? {
        guard let thumbnail = character?.thumbnail else { return nil }
        return ImageUrlBuilder.build(thumbnail: thumbnail,
                                     imageType: .standard_amazing)
    }

    var title: String? {
        character?.name
    }

    var description: String? {
        character?.description
    }

    init(characterId: Int,
         getCharacterDetail: GetCharacterDetail = ActionProvider.getCharacterDetail()) {
        self.getCharacterDetail = getCharacterDetail
        self.characterId = characterId
    }

    func loadCharacter() {
        view?.showLoanding()
        getCharacterDetail.execute(id: String(characterId)) { [weak self] character in
            guard let self = self else { return }
            self.character = character
            self.view?.reloadData()
            self.view?.dismissLoading()
        } failure: { error in
            self.view?.dismissLoading()
            self.view?.showError()
        }
    }
}
