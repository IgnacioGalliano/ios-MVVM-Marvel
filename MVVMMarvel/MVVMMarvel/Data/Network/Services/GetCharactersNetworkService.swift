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
    private let alamofireService: AlamoFireWrapperProtocol

    init(alamofireService: AlamoFireWrapperProtocol = AlamoFireWrapper()) {
        self.alamofireService = alamofireService
    }

    func execute(id: String?,
                 completion: @escaping (Result<ResponseListDTO, GetCharactersError>)  -> Void) {
        let url = CharactersEndpoint.buildURL(id: id)
        let parameters = CharactersEndpoint.parameters
        alamofireService.request(url: url,
                                 of: ResponseListDTO.self,
                                 parameters: parameters) { response in
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
