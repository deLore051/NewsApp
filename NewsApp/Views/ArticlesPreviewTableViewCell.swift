//
//  ArticlesPreviewTableViewCell.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 5.11.21..
//

import UIKit
import SDWebImage

class ArticlesPreviewTableViewCell: UITableViewCell {
    
    static let identifier = "ArticlesPreviewTableViewCell"
    
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
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        // PreviewArticleImageView
        previewArticleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        previewArticleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        previewArticleImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        previewArticleImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // ArticleTitleLabel
        articleTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        articleTitleLabel.leadingAnchor
            .constraint(equalTo: previewArticleImageView.trailingAnchor, constant: 10).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -130).isActive = true
        articleTitleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // ArticleDescriptionLabel
        articleDescriptionLabel.topAnchor
            .constraint(equalTo: previewArticleImageView.bottomAnchor, constant: 10).isActive = true
        articleDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        articleDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleDescriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // ArticleDateCreated
        articleDateCreatedLabel.topAnchor
            .constraint(equalTo: articleDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        articleDateCreatedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        articleDateCreatedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleDateCreatedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.previewArticleImageView.image = nil
        self.articleTitleLabel.text = nil
        self.articleDescriptionLabel.text = nil
        self.articleDateCreatedLabel.text = nil
    }
    
    public func configure(with article: Article) {
        guard let imageURL = article.urlToImage,
              let title = article.title,
              let description = article.description,
              let date = article.publishedAt else {
            return
        }
        
        guard let validImageURL = checkImageURL(for: imageURL) else {
            return
        }
        
        self.previewArticleImageView.sd_setImage(
            with: validImageURL,
            placeholderImage: UIImage(systemName: "photo"),
            options: .preloadAllFrames,
            completed: nil)
        self.articleTitleLabel.text = title
        self.articleDescriptionLabel.text = description
        self.articleDateCreatedLabel.text = "Created on: \(date)"
    }
    
    private func checkImageURL(for url: URL) -> URL? {
        var stringURL = url.description
        if stringURL.contains("//ocdn") {
            stringURL = "https:" + url.description
        }
        return URL(string: stringURL)
    }
    
}
