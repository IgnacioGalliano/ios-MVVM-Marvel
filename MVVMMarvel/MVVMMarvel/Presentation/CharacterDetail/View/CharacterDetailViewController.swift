//
//  CharacterDetailViewController.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

protocol CharacterDetailView: AnyObject {
    func showError()
    func reloadData()
    func showLoanding()
    func dismissLoading()
}

class CharacterDetailViewController: BaseViewController {
    private let viewModel: CharacterDetailViewModelable
    private let stackViewContainer = UIStackView()
    private let imagePresentation = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let errorLabel = UILabel()

    init(viewModel: CharacterDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        viewModel.loadCharacter()
    }

    private func setupView() {
        addSubviews()
        setupSubviews()
    }

    private func addSubviews() {
        view.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(imagePresentation)
        stackViewContainer.addArrangedSubview(titleLabel)
        stackViewContainer.addArrangedSubview(descriptionLabel)
        stackViewContainer.addArrangedSubview(UIView())
        setupConstraints()
    }

    private func setupConstraints() {
        addStackViewContainerConstraints()
        addImagePresentationConstraints()
    }

    private func addStackViewContainerConstraints() {
        stackViewContainer.addConstraints([
            equal(view, \.safeAreaLayoutGuide.leadingAnchor),
            equal(view, \.safeAreaLayoutGuide.trailingAnchor),
            equal(view, \.safeAreaLayoutGuide.topAnchor),
            equal(view, \.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func addImagePresentationConstraints() {
        imagePresentation.addConstraints([
            equal(\.heightAnchor, to: Constants.imagePresentationHeightAnchor)
        ])
    }

    private func setupSubviews() {
        setupStackViewContainer()
        setupImagePresentation()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    private func setupViewController() {
        let viewBackgroundController = UIView()
        viewBackgroundController.backgroundColor = .black
        view = viewBackgroundController
    }

    private func setupStackViewContainer() {
        stackViewContainer.backgroundColor = .black
        stackViewContainer.axis = .vertical
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.spacing = 5
    }

    private func setupImagePresentation() {
        guard let imageURL = viewModel.imagePresentationURL else { return }
        imagePresentation.contentMode = .scaleAspectFill
        imagePresentation.setImageByURL(imageURL)
    }

    private func setupTitleLabel() {
        guard let title = viewModel.title else { return }
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: titleLabel.font.fontName,
                                 size: Constants.titleLabelFontSize)
    }

    private func setupDescriptionLabel() {
        guard let description = viewModel.description else { return }
        descriptionLabel.text = description
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName,
                                       size: Constants.descriptionLabelFontSize)
    }

    private func setupErrorSubviews() {
        view.backgroundColor = .white
        addErrorSubviews()
        setupErrorLabel()
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

    private func setupErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.text = "Hubo un error en la carga de datos"
    }

    struct Constants {
        static let imagePresentationHeightAnchor: CGFloat = 400

        static let titleLabelFontSize: CGFloat = 40

        static let descriptionLabelFontSize: CGFloat = 20
    }
}

extension CharacterDetailViewController: CharacterDetailView {
    func reloadData() {
        Thread.ensureMainThread {
            self.errorLabel.removeFromSuperview()
            self.setupView()
        }
    }

    func showError() {
        Thread.ensureMainThread {
            self.stackViewContainer.removeFromSuperview()
            self.setupErrorSubviews()
        }
    }
}
