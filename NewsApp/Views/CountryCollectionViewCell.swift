//
//  CountryCollectionViewCell.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 31.10.21..
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CountryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.clipsToBounds = true
        return label
    }()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.clipsToBounds = true
        label.backgroundColor = .systemGray
        label.textColor = .white
        label.layer.cornerRadius = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(countryNameLabel)
        addSubview(countryCodeLabel)
        addConstraints()
        clipsToBounds = true
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        // ImageView
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40 ).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20).isActive = true
        
        // CountryNameLabel
        countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        countryNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        countryNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -150).isActive = true
        countryNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20).isActive = true
        
        // CountryNameLabel
        countryCodeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30).isActive = true
        countryCodeLabel.leadingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor, constant: 30).isActive = true
        countryCodeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        countryCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.countryNameLabel.text = nil
        self.countryCodeLabel.text = nil
    }
    
    public func configure(with country: Country) {
        self.countryNameLabel.text = country.name
        self.countryCodeLabel.text = country.code
        self.imageView.image = country.image
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.label.cgColor
    }
    
    public func getCountryCode() -> String {
        guard let code = countryCodeLabel.text else {
            return "default"
        }
        return code
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.layer.borderColor = UIColor.label.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = .systemBlue
            } else {
                self.backgroundColor = .systemBackground
            }
        }
    }
    

    
}
