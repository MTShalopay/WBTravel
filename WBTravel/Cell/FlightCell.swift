//
//  FlightCell.swift
//  WBTravel
//
//  Created by Shalopay on 13.05.2023.
//

import UIKit

class FlightCell: UITableViewCell {
    static var identifier = "FlightCell"
    
    private lazy var startCityLabel: CustomLabel = {
        let label = CustomLabel(text: "startCityLabel", fontName: UIFont.boldSystemFont(ofSize: 20), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    private lazy var startDateLabel: CustomLabel = {
        let label = CustomLabel(text: "startDateLabel", fontName: UIFont.italicSystemFont(ofSize: 15), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    
    private lazy var endCityLabel: CustomLabel = {
        let label = CustomLabel(text: "endCityLabel", fontName: UIFont.boldSystemFont(ofSize: 20), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    private lazy var endDateLabel: CustomLabel = {
        let label = CustomLabel(text: "endDateLabel", fontName: UIFont.italicSystemFont(ofSize: 15), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    
    private lazy var verticalLeftStackView: CustomStackView = {
        let stackView = CustomStackView(space: 10, axis: .vertical, distribution: .fill, alignment: .center)
        return stackView
    }()
    
    private lazy var verticalRightStackView: CustomStackView = {
        let stackView = CustomStackView(space: 10, axis: .vertical, distribution: .fill, alignment: .center)
        return stackView
    }()
    
    private lazy var priceLabel: CustomLabel = {
        let label = CustomLabel(text: "priceLabel", fontName: UIFont.boldSystemFont(ofSize: 25), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    public lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubviews([
            verticalLeftStackView, verticalRightStackView, priceLabel, likeButton
        ])
        verticalLeftStackView.addArrangedSubview(startDateLabel)
        verticalLeftStackView.addArrangedSubview(startCityLabel)
        
        verticalRightStackView.addArrangedSubview(endDateLabel)
        verticalRightStackView.addArrangedSubview(endCityLabel)
        NSLayoutConstraint.activate([
            verticalLeftStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalLeftStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            verticalRightStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalRightStackView.leadingAnchor.constraint(equalTo: verticalLeftStackView.trailingAnchor, constant: 10),

            priceLabel.topAnchor.constraint(equalTo: verticalLeftStackView.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    public func configureCell(_ flight: Flight) {
        startCityLabel.attributedText = NSAttributedString(string: flight.startCity)
        startDateLabel.attributedText = NSAttributedString(string: flight.startDate.convertDateFormat())
        endCityLabel.attributedText = NSAttributedString(string: flight.endCity)
        endDateLabel.attributedText = NSAttributedString(string: flight.endDate.convertDateFormat())
        priceLabel.attributedText = NSAttributedString(string: "\(flight.price) ₽")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
