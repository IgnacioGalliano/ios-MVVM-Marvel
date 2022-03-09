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
            equal(contentView, \.topAnchor, constant: 10),
            equal(contentView, \.bottomAnchor, constant: -10),
            equal(contentView, \.leadingAnchor, constant: 10),
            equal(contentView, \.trailingAnchor, constant: -10),
            equal(\.heightAnchor, to: 100)
        ])
    }

    private func addCharacterImageViewConstraints() {
        characterImageView.addConstraints([
            equal(cardView, \.centerYAnchor),
            equal(cardView, \.leadingAnchor, \.leadingAnchor, constant: 10),
            equal(\.heightAnchor, to: 70),
            equal(\.widthAnchor, to: 70)
        ])
    }

    private func addTitleLabelConstraints() {
        titleLabel.addConstraints([
            equal(characterImageView, \.topAnchor),
            equal(characterImageView, \.leadingAnchor, \.trailingAnchor, constant: 10),
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
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 4)
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOpacity = 0.5
    }

    private func addCardViewCornerRadius() {
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 4.0
    }

    func setupCharacterImageView(character: CharacterModel) {
        characterImageView.backgroundColor = .gray
        characterImageView.contentMode = .scaleAspectFit
        let imageURL = ImageUrlBuilder.build(thumbnail: character.thumbnail,
                                             imageType: .standard_xlarge)
        characterImageView.setImageByURL(imageURL)

        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = 4.0
    }

    func setupTitleLabel(character: CharacterModel) {
        titleLabel.text = character.name
    }
}
