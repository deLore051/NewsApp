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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 700)
        return  scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        return contentView
    }()
    
    /// Collection view for showing our categories options
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
                    let group = NSCollectionLayoutGroup.vertical(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(60)),
                        subitem: item,
                        count: 1)
                    
                    // Section
                    let section = NSCollectionLayoutSection(group: group)
                    return section
                }))
        collectionView.backgroundColor = .systemBackground
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    /// Button for confirming the selected categories and moving on to the next step.
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .medium)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Select Categories"
        addSubviews()
        addConstraints()
        createCategoriesModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    /// Method for adding subviews
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(nextButton)
    }
    
    /// Method for getting the selected categories stored and presenting the next VC after the button is tapped.
    @objc private func didTapNextButton() {
        nextButton.tapEffect(sender: nextButton)
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { return }
        for i in 0..<selectedItems.count {
            let index = selectedItems[i][1]
            selectedCategories.append(categoriesModel[index].categoryName)
        }
        checkIfselectedCategoriesIsEmpty()
        APIManager.shared.selectedCategories = self.selectedCategories
        self.selectedCategories = []
        let vc = NewsSourcesViewController()
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Method for checking if user selected any category before proceedeing to the next step.
    private func checkIfselectedCategoriesIsEmpty() {
        guard !selectedCategories.isEmpty else {
            let alert = UIAlertController(
                title: "Select category",
                message: "Please select at least one category to continue.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    /// Method for creating category models and storing them in an array for further usage.
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
    
    /// Method for adding constraints to our UI elements.
    private func addConstraints() {
        // ScrollView
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        // ContentView
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        // CollectionView
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        // NextButton
        nextButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /// Method for changeing the title to its state in portrait mode after orientation goes from landscape back to portrait.
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        navigationItem.largeTitleDisplayMode = .always
        coordinator.animate(alongsideTransition: { [weak self] (_) in
            guard let self = self else { return }
            self.navigationController?.navigationBar.sizeToFit()
        }, completion: nil)
    }
    
}

//MARK: - UICollectionViewDataSource_Delegate

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
        
}
