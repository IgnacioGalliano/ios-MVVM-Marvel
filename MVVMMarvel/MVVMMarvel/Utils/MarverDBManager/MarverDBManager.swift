//
//  MarverDBManager.swift
//  MVVMMarvel
//
//  Created by Nacho on 22/03/2023.
//

import Foundation

struct MarverDBManager {
    static var apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "MarvelMovieDB-info", ofType: "plist") else {
            fatalError("Couldn't find file 'MarvelMovieDB-Info.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'MarvelMovieDB-Info.plist'.")
        }
        return value
    }()

    static var hash: String = {
        guard let filePath = Bundle.main.path(forResource: "MarvelMovieDB-info", ofType: "plist") else {
            fatalError("Couldn't find file 'MarvelMovieDB-Info.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_HASH") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'MarvelMovieDB-Info.plist'.")
        }
        return value
    }()
}
