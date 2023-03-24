//
//  ResponseListDTO.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

struct ResponseListDTO: Decodable {
    let code: Int
    let data: ResponseDataDTO
}

struct ResponseDataDTO: Decodable {
    let count: Int
    let total: Int
    let limit: Int
    let offset: Int
    let results: [CharacterDTO]
}
