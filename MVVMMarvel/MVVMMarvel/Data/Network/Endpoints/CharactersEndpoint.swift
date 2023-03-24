//
//  CharactersEndpoint.swift
//  MVVMMarvel
//
//  Created by Nacho on 10/03/2022.
//

import Foundation

struct CharactersEndpoint {
    static func buildURL(id: String? = nil) -> String {
        let characterId = id != nil ? ("/" + id!) : ""
        return Constants.baseURL + Constants.versionPath + Constants.charactersPath + characterId
    }

    static let parameters = [Constants.ts: "1",
                             Constants.apikey: MarverDBManager.apiKey,
                             Constants.hash: MarverDBManager.hash]

    struct Constants {
        static let apikey = "apikey"
        static let ts = "ts"
        static let hash = "hash"
        static let baseURL = "http://gateway.marvel.com"
        static let versionPath = "/v1"
        static let charactersPath = "/public/characters"
    }
}
