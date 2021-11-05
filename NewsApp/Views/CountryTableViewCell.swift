//
//  CountryTableViewCell.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    static let identifier = "CountryTableViewCell"
    
    private let flagImageView: UIImageView = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(flagImageView)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(countryCodeLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        // ImageView
        flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 40 ).isActive = true
        flagImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20).isActive = true
        
        // CountryNameLabel
        countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        countryNameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10).isActive = true
        countryNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -150).isActive = true
        countryNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20).isActive = true
        
        // CountryNameLabel
        countryCodeLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: -30).isActive = true
        countryCodeLabel.leadingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor, constant: 30).isActive = true
        countryCodeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        countryCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flagImageView.image = nil
        self.countryNameLabel.text = nil
        self.countryCodeLabel.text = nil
    }
    
    public func configure(with country: Country) {
        self.countryNameLabel.text = country.name
        self.countryCodeLabel.text = country.code
        self.flagImageView.image = country.image
    }
    
    public func getCountryCode() -> String {
        guard let code = countryCodeLabel.text else {
            return "default"
        }
        return code
    }

    
    
}
