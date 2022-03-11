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
    var viewModelMock: CharactersListViewModelPartialSpy!

    func testCellViewControllerPressed() {
        givenASut()
        whenACellIsPressed()
        thenAssertInvokedCellPressed()
    }


    // MARK: - UI TESTS

    func testViewControllerWithOneCharacter() {
        givenASut()
        whenTheViewControllerReloadDataWithOneCharacter()
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }

    func testViewControllerWithError() {
        givenASut()
        whenTheViewControllerShowError()
        assertSnapshot(matching: sut, as: .image(on: .iPhoneX))
    }

    func givenASut() {
        viewModelMock = CharactersListViewModelPartialSpy()
        sut = CharactersListViewController(viewModel: viewModelMock)
    }

    func whenACellIsPressed() {
        let index = IndexPath(row: 1, section: 0)
        sut.tableView(UITableView(), didSelectRowAt: index)
    }

    func whenTheViewControllerReloadDataWithOneCharacter() {
        let thumbnail = Thumbnail(path: "",
                                  imageExtension: "")
        let character = CharacterModel(id: 1,
                                       name: "test",
                                       description: "es un test",
                                       thumbnail: thumbnail)
        viewModelMock.stubbedGetQuantityOfCharacters = 1
        viewModelMock.stubbedGetCharactersResult = character
        sut.reloadData()
    }

    func whenTheViewControllerShowError() {
        sut.showError(message:"ErrorLoadingData")
    }

    func thenAssertInvokedCellPressed() {
        XCTAssertTrue(viewModelMock.invokedCellPressed)
    }
}
