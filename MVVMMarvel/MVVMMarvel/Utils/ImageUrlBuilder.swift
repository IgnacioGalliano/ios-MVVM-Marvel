//
//  ImageUrlBuilder.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

class ImageUrlBuilder {
    static func build(thumbnail: Thumbnail, imageType: ImageType) -> String {
        return thumbnail.path + "/" + imageType.rawValue + "." + thumbnail.imageExtension
    }

    enum ImageType: String {
        case standard_xlarge
        case standard_fantastic
        case standard_amazing
    }
}
