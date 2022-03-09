//
//  UIImageView+Alamofire.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit
import Alamofire

extension UIImageView {
    func setImageByURL(_ url: String) {
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                guard let responseData = responseData else {
                    // we could track error here
                    return
                }
                self.image = UIImage(data: responseData)
            case .failure(let error):
                print("error--->", error)
                // we could track error here
            }
        }
    }
}
