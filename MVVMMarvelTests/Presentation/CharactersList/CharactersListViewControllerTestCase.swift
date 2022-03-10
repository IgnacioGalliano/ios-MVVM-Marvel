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

    func givenASut() {
        viewModelMock = CharactersListViewModelPartialSpy()
        sut = CharactersListViewController(viewModel: viewModelMock)
    }

    func whenACellIsPressed() {
        let index = IndexPath(row: 1, section: 0)
        sut.tableView(UITableView(), didSelectRowAt: index)
    }

    func thenAssertInvokedCellPressed() {
        XCTAssertTrue(viewModelMock.invokedCellPressed)
    }
}
