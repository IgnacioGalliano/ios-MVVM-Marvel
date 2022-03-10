//
//  CharactersTableViewCell.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    let cardView = UIView()
    let characterImageView = UIImageView()
    let titleLabel = UILabel()

    func setupSubviews(character: CharacterModel) {
        addSubviews()
        addConstraints()

        setupCarView()
        setupCharacterImageView(character: character)
        setupTitleLabel(character: character)
    }

    private func addSubviews() {
        contentView.addSubview(cardView)
        cardView.addSubview(characterImageView)
        cardView.addSubview(titleLabel)
    }

    private func addConstraints() {
        addCarViewConstraints()
        addCharacterImageViewConstraints()
        addTitleLabelConstraints()
    }

    private func addCarViewConstraints() {
        cardView.addConstraints([
            equal(contentView, \.topAnchor, constant: Constants.cardViewTopAnchor),
            equal(contentView, \.bottomAnchor, constant: Constants.cardViewBottomAnchor),
            equal(contentView, \.leadingAnchor, constant: Constants.cardViewLeadingAnchor),
            equal(contentView, \.trailingAnchor, constant: Constants.cardViewTrailingAnchor),
            equal(\.heightAnchor, to: Constants.cardViewHeightAnchor)
        ])
    }

    private func addCharacterImageViewConstraints() {
        characterImageView.addConstraints([
            equal(cardView, \.centerYAnchor),
            equal(cardView, \.leadingAnchor, \.leadingAnchor, constant: Constants.characterImageViewLeadingAnchor),
            equal(\.heightAnchor, to: Constants.characterImageViewHeightAnchor),
            equal(\.widthAnchor, to: Constants.characterImageViewWidthAnchor)
        ])
    }

    private func addTitleLabelConstraints() {
        titleLabel.addConstraints([
            equal(characterImageView, \.topAnchor),
            equal(characterImageView, \.leadingAnchor, \.trailingAnchor, constant: Constants.titleLabelLeadingAnchor),
            equal(cardView, \.trailingAnchor, \.trailingAnchor, constant: .zero)
        ])
    }

    private func setupCarView() {
        cardView.backgroundColor = .white
        addCardViewShadow()
        addCardViewCornerRadius()
    }

    private func addCardViewShadow() {
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: Constants.shadowWidth,
                                             height: Constants.shadowHeight)
        cardView.layer.shadowRadius = Constants.commonCornerRadius
        cardView.layer.shadowOpacity = Constants.shadowOpacity
    }

    private func addCardViewCornerRadius() {
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = Constants.commonCornerRadius
    }

    func setupCharacterImageView(character: CharacterModel) {
        characterImageView.backgroundColor = .gray
        characterImageView.contentMode = .scaleAspectFit
        let imageURL = ImageUrlBuilder.build(thumbnail: character.thumbnail,
                                             imageType: .standard_xlarge)
        characterImageView.setImageByURL(imageURL)

        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = Constants.commonCornerRadius
    }

    func setupTitleLabel(character: CharacterModel) {
        titleLabel.text = character.name
    }

    struct Constants {
        static let cardViewTopAnchor: CGFloat = 10
        static let cardViewBottomAnchor: CGFloat = -10
        static let cardViewTrailingAnchor: CGFloat = -10
        static let cardViewLeadingAnchor: CGFloat = 10
        static let cardViewHeightAnchor: CGFloat = 100

        static let characterImageViewLeadingAnchor: CGFloat = 10
        static let characterImageViewHeightAnchor: CGFloat = 70
        static let characterImageViewWidthAnchor: CGFloat = 70

        static let titleLabelLeadingAnchor: CGFloat = 10

        static let commonCornerRadius: CGFloat = 4

        static let shadowOpacity: Float = 0.5
        static let shadowHeight: CGFloat = 4
        static let shadowWidth: CGFloat = 0
    }
}
