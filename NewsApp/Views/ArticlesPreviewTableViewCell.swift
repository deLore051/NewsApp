//
//  ArticlesPreviewTableViewCell.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 5.11.21..
//

import UIKit

class ArticlesPreviewTableViewCell: UITableViewCell {
    
    private let previewArticleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let articleDateCreatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(previewArticleImageView)
        contentView.addSubview(articleTitleLabel)
        contentView.addSubview(articleDescriptionLabel)
        contentView.addSubview(articleDateCreatedLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.previewArticleImageView.image = nil
        self.articleTitleLabel.text = nil
        self.articleDescriptionLabel.text = nil
        self.articleDateCreatedLabel.text = nil
    }
    
    public func configure(with imageURL: String, title: String, description: String, dateCreated: String) {
        
    }
    
}
