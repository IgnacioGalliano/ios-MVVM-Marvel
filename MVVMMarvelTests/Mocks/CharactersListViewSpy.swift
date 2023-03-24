//
//  CharactersListViewSpy.swift
//  MVVMMarvelTests
//
//  Created by Nacho on 09/03/2022.
//

import UIKit
@testable import MVVMMarvel

class CharactersListViewSpy: CharactersListView {
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (message: String, Void)?
    var invokedShowErrorParametersList = [(message: String, Void)]()

    func showError(message: String) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (message, ())
        invokedShowErrorParametersList.append((message, ()))
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedShowLoanding = false
    var invokedShowLoandingCount = 0

    func showLoanding() {
        invokedShowLoanding = true
        invokedShowLoandingCount += 1
    }

    var invokedDismissLoading = false
    var invokedDismissLoadingCount = 0

    func dismissLoading() {
        invokedDismissLoading = true
        invokedDismissLoadingCount += 1
    }

    var invokedPushController = false
    var invokedPushControllerCount = 0
    var invokedPushControllerParameters: (controller: UIViewController, Void)?
    var invokedPushControllerParametersList = [(controller: UIViewController, Void)]()

    func pushController(controller: UIViewController) {
        invokedPushController = true
        invokedPushControllerCount += 1
        invokedPushControllerParameters = (controller, ())
        invokedPushControllerParametersList.append((controller, ()))
    }
}
