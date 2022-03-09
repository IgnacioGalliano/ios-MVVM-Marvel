//
//  CharactersListBuilder.swift
//  MVVMMarvel
//
//  Created by Nacho on 09/03/2022.
//

import Foundation

class CharactersListBuilder {
    static func build() -> CharactersListViewController {
        let coordinator = CharactersListCoordinator()
        let viewModel = CharactersListViewModel(coordinator: coordinator)
        let view = CharactersListViewController(viewModel: viewModel)
        viewModel.view = view
        coordinator.view = view
        return view
    }
}
