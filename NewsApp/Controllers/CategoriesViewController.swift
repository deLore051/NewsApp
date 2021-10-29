//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import UIKit

class CategoriesViewController: UIViewController {

    private var selectedCategories: [String] = []
    private var categoriesModel: [Category] = []
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider: { _, _ -> NSCollectionLayoutSection? in
                    // Item
                    let item = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .fractionalHeight(1.0)))
                    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                    
                    // Group
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(150)),
                        subitem: item,
                        count: 2)
                    
                    // Section
                    let section = NSCollectionLayoutSection(group: group)
                    return section
                }))
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Select Categories"
        view.addSubview(collectionView)
        addConstraints()
        createCategoriesModel()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createCategoriesModel() {
        for i in 0...6 {
            guard let image = UIImage(named: Constansts.categoryImages[i]) else { return }
            let newsCategory = Category(
                categoryImage: image,
                categoryName: Constansts.categoryNames[i])
            categoriesModel.append(newsCategory)
        }
        collectionView.reloadData()
    }
    
    private func addConstraints() {
        // CollectionView
        collectionView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.widthAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant:  -20).isActive = true
        collectionView.heightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant:  -10).isActive = true
    }
    
}


extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoriesModel.count > 0 {
            return categoriesModel.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath) as! CategoryCollectionViewCell
        cell.configure(with: categoriesModel[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
