//
//  ViewArticleViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import UIKit
import SDWebImage

class ViewArticleViewController: UIViewController {
    
    private var article: Article
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
        scrollView.clipsToBounds = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let articleSourceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.clipsToBounds = true
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.clipsToBounds = true
        return label
    }()
    
    private let articleDateCreatedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        addConstraints()
        configureView()
        scrollView.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(articleTitleLabel)
        contentView.addSubview(articleSourceLabel)
        contentView.addSubview(articleImageView)
        contentView.addSubview(articleDescriptionLabel)
        contentView.addSubview(articleAuthorLabel)
        contentView.addSubview(articleDateCreatedLabel)
    }
    
    private func addConstraints() {
        // ScrollView
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        // ContentView
        contentView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        
        // ArticleTitleLabel
        articleTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        articleTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        // ArticleSourceLabel
        articleSourceLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        articleSourceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleSourceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleSourceLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // ArticleImageView
        articleImageView.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10).isActive = true
        articleImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        // ArticleDescriptionLabel
        articleDescriptionLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10).isActive = true
        articleDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 250).isActive = true
        
        // ArticleAuthorLabel
        articleAuthorLabel.topAnchor.constraint(equalTo: articleDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        articleAuthorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleAuthorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleAuthorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // ArticleDateCreatedLabel
        articleDateCreatedLabel.topAnchor.constraint(equalTo: articleAuthorLabel.bottomAnchor).isActive = true
        articleDateCreatedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        articleDateCreatedLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        articleDateCreatedLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    private func configureView() {
        guard let title = article.title,
              let sourceName = article.source.name,
              let imageURL = article.urlToImage,
              let date = article.publishedAt else { return }
        
        guard let validImageURL = ArticlesManager.shared.checkImageURL(for: imageURL) else {
            return
        }
        
        self.articleTitleLabel.text = title
        self.articleSourceLabel.text = "Source: \(sourceName)"
        self.articleImageView.sd_setImage(
            with: validImageURL,
            placeholderImage: UIImage(systemName: "photo"),
            options: .preloadAllFrames)
        self.articleDescriptionLabel.text = article.content ?? ""
        self.articleAuthorLabel.text = "Author: \(article.author ?? "")"
        self.articleDateCreatedLabel.text = "Created on: \(String(date.prefix(10)))"
    }
    
}


extension ViewArticleViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
}
