//
//  Thread.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import Foundation

extension Thread {
    static func ensureMainThread(callbackOnMain: @escaping () -> Void) {
        if Thread.current.isMainThread {
            callbackOnMain()
        } else {
            DispatchQueue.main.async {
                callbackOnMain()
            }
        }
    }
}
