//
//  CharactersListViewControllerTestCase.swift
//  MVVMMarvelUITests
//
//  Created by Nacho on 08/03/2022.
//

import XCTest
@testable import MVVMMarvel
import SnapshotTesting

class CharactersListViewControllerTestCase: XCTestCase {
    var sut: CharactersListViewController!
    var viewModelMock: CharactersListViewModel!
    var getCharactersMock: GetCharactersMock!
    var charactersListCoordinatableSpy: CharactersListCoordinatableSpy!

//    func testAlertLoadingViewController() {
//        givenASut()
//        whenTheSutIsLoading()
//        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
//    }

    func testShowFailLoadViewController() {
        givenASut()
        whenTheSutIsShowingError()
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }

    func givenASut() {
        charactersListCoordinatableSpy = CharactersListCoordinatableSpy()
        getCharactersMock = GetCharactersMock()
        viewModelMock = CharactersListViewModel(getCharacters: getCharactersMock,
                                                coordinator: charactersListCoordinatableSpy)
        sut = CharactersListViewController(viewModel: viewModelMock)
    }

    func whenTheSutIsLoading() {
        getCharactersMock.response = false
        _ = sut.view
        sut.viewDidLoad()
        viewModelMock.loadCharacters()
    }

    func whenTheSutIsShowingError() {
        getCharactersMock.error = [NSError(domain: "", code: 400, userInfo: nil)]
        _ = sut.view
        viewModelMock.loadCharacters()
    }
}

class GetCharactersMock: GetCharacters {
    var response = true
    var error: [Error]!
    var characterList: [CharacterModel]!

    func execute(success: @escaping ([CharacterModel]) -> Void,
                 failure: @escaping ([Error]) -> Void) {
        guard response else { return }
        if let characterList = characterList {
            success(characterList)
        } else {
            failure(error)
        }
    }
}

class CharactersListCoordinatableSpy: CharactersListCoordinatable {
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
