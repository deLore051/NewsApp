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
    
    private let sourceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
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
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        contentView.addSubview(sourceNameLabel)
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
        // SourceNameLabel
        sourceNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        sourceNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        sourceNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        sourceNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        // ArticleTitleLabel
        articleTitleLabel.topAnchor.constraint(equalTo: sourceNameLabel.bottomAnchor).isActive = true
        articleTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        // PreviewArticleImageView
        previewArticleImageView.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        previewArticleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        previewArticleImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        previewArticleImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
        
        // ArticleDescriptionLabel
        articleDescriptionLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        articleDescriptionLabel.leadingAnchor
            .constraint(equalTo: previewArticleImageView.trailingAnchor, constant: 10).isActive = true
        articleDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -180).isActive = true
        articleDescriptionLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // ArticleDateCreated
        articleDateCreatedLabel.topAnchor
            .constraint(equalTo: previewArticleImageView.bottomAnchor, constant: 10).isActive = true
        articleDateCreatedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        articleDateCreatedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleDateCreatedLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sourceNameLabel.text = nil
        self.previewArticleImageView.image = nil
        self.articleTitleLabel.text = nil
        self.articleDescriptionLabel.text = nil
        self.articleDateCreatedLabel.text = nil
    }
    
    public func configure(with model: Article) {
        guard let imageURL = model.urlToImage,
              let sourceName = model.source.name,
              let title = model.title,
              let description = model.description,
              let date = model.publishedAt else {
            return
        }
        
        guard let validImageURL = ArticlesManager.shared.checkImageURL(for: imageURL) else {
            return
        }
        
        self.sourceNameLabel.text = "--- \(sourceName) ---"
        self.previewArticleImageView.sd_setImage(
            with: validImageURL,
            placeholderImage: UIImage(systemName: "photo"),
            options: .preloadAllFrames,
            completed: nil)
        self.articleTitleLabel.text = title
        self.articleDescriptionLabel.text = description
        self.articleDateCreatedLabel.text = "Created on: \(String(date.prefix(10)))"
    }
    
    
    
}
