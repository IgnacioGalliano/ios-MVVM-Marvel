//
//  CharactersEndpoint.swift
//  MVVMMarvel
//
//  Created by Nacho on 10/03/2022.
//

import Foundation

struct CharactersEndpoint {
    private static let baseURL = "http://gateway.marvel.com"
    private static let versionPath = "/v1"
    private static let charactersPath = "/public/characters"
    static func buildURL(id: String? = nil) -> String {
        let characterId = id != nil ? ("/" + id!) : ""
        return baseURL + versionPath + charactersPath + characterId
    }
    static let parameters = ["ts": "1",
                             "apikey": "a0994bdcfbe469094edceacfd33177f2",
                             "hash": "6c715e487f563c24a29c71e9045b05cd"]
}
