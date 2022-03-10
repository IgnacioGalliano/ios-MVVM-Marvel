//
//  GetCharactersPartialSpy.swift
//  MVVMMarvelTests
//
//  Created by Nacho on 09/03/2022.
//

@testable import MVVMMarvel

class GetCharactersPartialSpy: GetCharacters {
    var invokedExecute = false
    var invokedExecuteCount = 0
    var stubbedExecuteSuccessResult: ([CharacterModel], Void)?
    var stubbedExecuteFailureResult: (GetCharactersError, Void)?

    func execute(success: @escaping ([CharacterModel]) -> Void,
        failure: @escaping (GetCharactersError) -> Void) {
        invokedExecute = true
        invokedExecuteCount += 1
        if let result = stubbedExecuteSuccessResult {
            success(result.0)
        }
        if let result = stubbedExecuteFailureResult {
            failure(result.0)
        }
    }
}
