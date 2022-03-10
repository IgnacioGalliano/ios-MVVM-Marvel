//
//  GetCharactersError.swift
//  MVVMMarvel
//
//  Created by Nacho on 09/03/2022.
//

import Foundation

enum GetCharactersError: Error {
    case generic(message: String)
    case foundNil
}
