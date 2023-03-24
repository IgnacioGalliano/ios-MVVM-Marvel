//
//  CharactersListViewModelTestCase.swift
//  MVVMMarvelTests
//
//  Created by Nacho on 09/03/2022.
//

import XCTest
@testable import MVVMMarvel

class CharactersListViewModelTestCase: XCTestCase {
    var sut: CharactersListViewModel!
    var getCharactersSpy: GetCharactersPartialSpy!
    var charactersListCoordinatePartialSpy: CharactersListCoordinatePartialSpy!
    var viewSpy: CharactersListViewSpy!


    func testInvokeShowLoading() {
        givenASut()
        whenExecuteLoadCharacters()
        thenAssertInvokedLoading()
    }

    func testInvokeReloadDataAndDismissLoading() {
        givenASut()
        whenTheRequestIsSuccess()
        thenAssertDismissLoadingAndInvokedReloadData()
    }

    func testInvokeShowErrorAndDismissLoading() {
        givenASut()
        whenTheRequestFail()
        thenAssertInvokedLoading()
    }

    func testGetQuantityOfCharacters() {
        givenASut()
        whenTheRequestIsSuccess()
        thenAssertInvokedLoading()
    }

    func testGetCharacter() {
        givenASut()
        whenTheRequestIsSuccess()
        thenAssertCharacter()
    }

    func testCellPressed() {
        givenASut()
        whenTheRequestIsSuccess()
        thenAssertCharacter()
    }

    func givenASut() {
        viewSpy = CharactersListViewSpy()
        getCharactersSpy = GetCharactersPartialSpy()
        charactersListCoordinatePartialSpy = CharactersListCoordinatePartialSpy()
        sut = CharactersListViewModel(getCharacters: getCharactersSpy,
                                      coordinator: charactersListCoordinatePartialSpy)
        sut.view = viewSpy
    }

    func whenExecuteLoadCharacters() {
        sut.loadCharacters()
    }

    func whenTheRequestIsSuccess() {
        getCharactersSpy.stubbedExecuteSuccessResult = ([CharacterModel(id: 1,
                                                                        name: "test",
                                                                        description: "es un test",
                                                                        thumbnail: Thumbnail(path: "",
                                                                                             imageExtension: ""))], ())
        whenExecuteLoadCharacters()
    }

    func whenTheRequestFail() {
        getCharactersSpy.stubbedExecuteFailureResult = (.generic(message: "Error"), ())
        whenExecuteLoadCharacters()
    }

    func whenACellIsPressed() {
        whenTheRequestIsSuccess()
        sut.cellPressed(indexPath: IndexPath(row: 0, section: 0))
    }

    func thenAssertInvokedLoading() {
        XCTAssertTrue(viewSpy.invokedShowLoanding)
    }

    func thenAssertDismissLoading() {
        XCTAssertTrue(viewSpy.invokedDismissLoading)
    }

    func thenAssertDismissLoadingAndInvokedReloadData() {
        thenAssertDismissLoading()
        XCTAssertTrue(viewSpy.invokedReloadData)
    }

    func thenAssertDismissLoadingAndInvokedShowError() {
        thenAssertDismissLoading()
        XCTAssertTrue(viewSpy.invokedShowError)
    }

    func thenAssertQuantityOfCharacters() {
        XCTAssertEqual(sut.getQuantityOfCharacters, 1)
    }

    func thenAssertCharacter() {
        let character = sut.getCharacters(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "test")
        XCTAssertEqual(character.description, "es un test")
    }

    func thenAssertCoordinatorOpenDetailAndVCPushDetailIsInvoked() {
        XCTAssertTrue(viewSpy.invokedPushController)
        XCTAssertTrue(charactersListCoordinatePartialSpy.invokedOpenDetail)
        let (character, _) = charactersListCoordinatePartialSpy.invokedOpenDetailParameters!
        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "test")
        XCTAssertEqual(character.description, "es un test")
    }
}


