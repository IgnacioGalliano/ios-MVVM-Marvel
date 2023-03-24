//
//  CharacterDetailBuilder.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

class CharacterDetailBuilder {
    static func build(characterId: Int) -> CharacterDetailViewController {
        let viewModel = CharacterDetailViewModel(characterId: characterId)
        let view = CharacterDetailViewController(viewModel: viewModel)
        viewModel.view = view
        return view
    }
}
