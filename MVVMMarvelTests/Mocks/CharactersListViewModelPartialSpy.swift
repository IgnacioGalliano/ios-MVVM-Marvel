//
//  CharactersListViewModelPartialSpy.swift
//  MVVMMarvelTests
//
//  Created by Nacho on 09/03/2022.
//

import Foundation
@testable import MVVMMarvel

class CharactersListViewModelPartialSpy: CharactersListViewModelable {
    var invokedGetQuantityOfCharactersGetter = false
    var invokedGetQuantityOfCharactersGetterCount = 0
    var stubbedGetQuantityOfCharacters: Int! = 0

    var getQuantityOfCharacters: Int {
        invokedGetQuantityOfCharactersGetter = true
        invokedGetQuantityOfCharactersGetterCount += 1
        return stubbedGetQuantityOfCharacters
    }

    var invokedViewSetter = false
    var invokedViewSetterCount = 0
    var invokedView: CharactersListView?
    var invokedViewList = [CharactersListView?]()
    var invokedViewGetter = false
    var invokedViewGetterCount = 0
    var stubbedView: CharactersListView!

    var view: CharactersListView? {
        set {
            invokedViewSetter = true
            invokedViewSetterCount += 1
            invokedView = newValue
            invokedViewList.append(newValue)
        }
        get {
            invokedViewGetter = true
            invokedViewGetterCount += 1
            return stubbedView
        }
    }

    var invokedLoadCharacters = false
    var invokedLoadCharactersCount = 0

    func loadCharacters() {
        invokedLoadCharacters = true
        invokedLoadCharactersCount += 1
    }

    var invokedGetCharacters = false
    var invokedGetCharactersCount = 0
    var invokedGetCharactersParameters: (indexPath: IndexPath, Void)?
    var invokedGetCharactersParametersList = [(indexPath: IndexPath, Void)]()
    var stubbedGetCharactersResult: CharacterModel!

    func getCharacters(indexPath: IndexPath) -> CharacterModel {
        invokedGetCharacters = true
        invokedGetCharactersCount += 1
        invokedGetCharactersParameters = (indexPath, ())
        invokedGetCharactersParametersList.append((indexPath, ()))
        return stubbedGetCharactersResult
    }

    var invokedCellPressed = false
    var invokedCellPressedCount = 0
    var invokedCellPressedParameters: (indexPath: IndexPath, Void)?
    var invokedCellPressedParametersList = [(indexPath: IndexPath, Void)]()

    func cellPressed(indexPath: IndexPath) {
        invokedCellPressed = true
        invokedCellPressedCount += 1
        invokedCellPressedParameters = (indexPath, ())
        invokedCellPressedParametersList.append((indexPath, ()))
    }
}
