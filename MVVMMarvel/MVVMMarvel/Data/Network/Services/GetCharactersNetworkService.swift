//
//  GetCharactersNetworkService.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Alamofire

protocol GetMoviesNetworkService {
    func execute(id: String?,
                 success: @escaping (ResponseListDTO) -> Void,
                 failure: @escaping ([Error]) -> Void)
}

class DefaultGetCharactersNetworkService: GetMoviesNetworkService {
//    private let netwotkService: GetMoviesNetworkService

    init() {
//        self.netwotkService = networkService
    }

    func execute(id: String?,
                 success: @escaping (ResponseListDTO) -> Void,
                 failure: @escaping ([Error]) -> Void) {
        let url = Constants.moviesURL(id: id)
        AF.request(url).responseDecodable(of: ResponseListDTO.self) { response in
            switch response.result {
            case .success(let result):
                success(result)
            case .failure(let error):
                print(error)
                failure([error])
            }
        }
    }

    struct Constants {
        private static let baseURL = "http://gateway.marvel.com"
        private static let v1 = "/v1"
        private static let moviesPath = "/public/characters"
        private static let timeStamp = "?ts=1"
        private static let apiKey = "&apikey=a0994bdcfbe469094edceacfd33177f2"
        private static let hash = "&hash=6c715e487f563c24a29c71e9045b05cd"
        static func moviesURL(id: String? = nil) -> String {
            let characterId = id != nil ? ("/" + id!) : ""
            return baseURL + v1 + moviesPath + characterId + timeStamp + apiKey + hash
        }
    }
}
