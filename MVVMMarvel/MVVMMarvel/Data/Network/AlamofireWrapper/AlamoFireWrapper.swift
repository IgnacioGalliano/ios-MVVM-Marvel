//
//  AlamoFireWrapper.swift
//  MVVMMarvel
//
//  Created by Nacho on 27/03/2022.
//

import Alamofire

protocol AlamoFireWrapperProtocol {
    func request<DTOType: Decodable, Parameters: Encodable>(url: String,
                                                            of type: DTOType.Type,
                                                            parameters: Parameters,
                                                            completion: @escaping (DataResponse<DTOType, AFError>) -> ())
}

class AlamoFireWrapper: AlamoFireWrapperProtocol {
    func request<DTOType: Decodable, Parameters: Encodable>(url: String,
                                                            of type: DTOType.Type = DTOType.self,
                                                            parameters: Parameters,
                                                            completion: @escaping (DataResponse<DTOType, AFError>) -> ()) {
        AF.request(url, parameters: parameters).responseDecodable(of: type) { response in
            completion(response)
        }
    }
}
