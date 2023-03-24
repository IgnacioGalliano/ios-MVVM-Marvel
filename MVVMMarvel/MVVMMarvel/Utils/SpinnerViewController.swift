//
//  SpinnerViewController.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

class BaseViewController: UIViewController {
    let alert = UIAlertController(title: nil, message: "Cargando...", preferredStyle: .alert)

    func showLoanding() {
        Thread.ensureMainThread {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            self.alert.view.addSubview(loadingIndicator)
            self.present(self.alert,
                         animated: false,
                         completion: nil)
        }
    }

    func dismissLoading() {
        Thread.ensureMainThread {
            self.alert.dismiss(animated: true,
                               completion: nil)
        }
    }
}
