//
//  GetCharactersNetworkService.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Alamofire

protocol GetCharactersNetworkService {
    func execute(id: String?,
                 completion: @escaping (Result<ResponseListDTO, GetCharactersError>) -> Void)
}

class DefaultGetCharactersNetworkService: GetCharactersNetworkService {
    func execute(id: String?,
                 completion: @escaping (Result<ResponseListDTO, GetCharactersError>)  -> Void) {
        let url = CharactersEndpoint.buildURL(id: id)
        let parameters = CharactersEndpoint.parameters
        AF.request(url, parameters: parameters).responseDecodable(of: ResponseListDTO.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                print(error)
                completion(.failure(.generic(message: Localizable.errorLoadingData)))
            }
        }
    }
}
