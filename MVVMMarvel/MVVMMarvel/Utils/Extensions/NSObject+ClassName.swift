//
//  NSObject+ClassName.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

public extension NSObject {
    class var nibName: String {
        if let name = String(describing: self).components(separatedBy: ".").last {
            return name
        }
        return String(describing: self)
    }
}
