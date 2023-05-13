//
//  FlightDetailVC.swift
//  WBTravel
//
//  Created by Shalopay on 13.05.2023.
//

import UIKit

class FlightDetailVC: UIViewController {
    let userDefault = UserDefaults.standard
    
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
    
    private lazy var verticalStackView: CustomStackView = {
        let stackView = CustomStackView(space: 10, axis: .vertical, distribution: .equalSpacing, alignment: .center)
        //stackView.backgroundColor = .black
        return stackView
    }()
    
    private lazy var priceLabel: CustomLabel = {
        let label = CustomLabel(text: "priceLabel", fontName: UIFont.boldSystemFont(ofSize: 25), colorText: .black, lineHeightMultiple: 0.0, kern: 0.0)
        return label
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.isSelected = userDefault.bool(forKey: "isLiked")
        button.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        likeButton.isSelected = userDefault.bool(forKey: "\(likeButton.tag)")
    }
    public func configureView(_ flight: Flight, buttonTag: Int) {
        startCityLabel.attributedText = NSAttributedString(string: flight.startCity)
        startDateLabel.attributedText = NSAttributedString(string: flight.startDate.convertDateFormat())
        endCityLabel.attributedText = NSAttributedString(string: flight.endCity)
        endDateLabel.attributedText = NSAttributedString(string: flight.endDate.convertDateFormat())
        priceLabel.attributedText = NSAttributedString(string: "Стоимость: \(flight.price) ₽")
        likeButton.tag = buttonTag
    }
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(startDateLabel)
        verticalStackView.addArrangedSubview(startCityLabel)
        verticalStackView.addArrangedSubview(endDateLabel)
        verticalStackView.addArrangedSubview(endCityLabel)
        verticalStackView.addArrangedSubview(priceLabel)
        verticalStackView.addArrangedSubview(likeButton)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            verticalStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 5),
        ])
    }
    
    @objc private func changeLike(sender: CustomButton) {
        print("SENDER:\(sender.tag)")
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        userDefault.set(sender.isSelected, forKey: "\(sender.tag)")
    }
}
