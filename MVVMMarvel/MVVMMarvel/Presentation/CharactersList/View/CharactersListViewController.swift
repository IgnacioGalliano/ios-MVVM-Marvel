//
//  CharactersListViewController.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

protocol CharactersListView: AnyObject {
    func showError(message: String)
    func reloadData()
    func showLoanding()
    func dismissLoading()
    func pushController(controller: UIViewController)
}

class CharactersListViewController: BaseViewController {
    private let viewModel: CharactersListViewModelable
    private let charactersTableView = UITableView(frame: .zero,
                                                  style: .plain)
    private let errorLabel = UILabel()

    init(viewModel: CharactersListViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCharacters()
    }

    private func setupSubviews() {
        addSubviews()
        setupTableView()
    }

    private func addSubviews() {
        view.addSubview(charactersTableView)
        setupConstraints()
    }

    private func setupConstraints() {
        addTableViewConstraints()
    }

    private func addTableViewConstraints() {
        charactersTableView.addConstraints([
            equal(view, \.safeAreaLayoutGuide.leadingAnchor),
            equal(view, \.safeAreaLayoutGuide.trailingAnchor),
            equal(view, \.safeAreaLayoutGuide.topAnchor),
            equal(view, \.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTableView() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.allowsSelection = true
        charactersTableView.separatorStyle = .none
        charactersTableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.nibName)
    }

    private func setupErrorSubviews(message: String) {
        view.backgroundColor = .white
        addErrorSubviews()
        setupErrorLabel(message: message)
    }

    private func addErrorSubviews() {
        view.addSubview(errorLabel)
        setupErrorConstraints()
    }

    private func setupErrorConstraints() {
        errorLabel.addConstraints([
            equal(view, \.centerXAnchor),
            equal(view, \.centerYAnchor)
        ])
    }

    private func setupErrorLabel(message: String) {
        errorLabel.textColor = .red
        errorLabel.text = message
    }
}

extension CharactersListViewController: CharactersListView {
    func pushController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller,
                                                      animated: true)
    }

    func reloadData() {
        Thread.ensureMainThread {
            self.errorLabel.removeFromSuperview()
            self.setupSubviews()
            self.charactersTableView.reloadData()
        }
    }

    func showError(message: String) {
        Thread.ensureMainThread {
            self.charactersTableView.removeFromSuperview()
            self.setupErrorSubviews(message: message)
        }
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getQuantityOfCharacters
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.nibName,
                                                           for: indexPath)
        if let cell = cell as? CharactersTableViewCell {
            let character = viewModel.getCharacters(indexPath: indexPath)
            cell.setupSubviews(character: character)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellPressed(indexPath: indexPath)
    }
}
