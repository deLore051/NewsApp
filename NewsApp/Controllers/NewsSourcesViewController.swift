//
//  NewsSourcesViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import UIKit
import FlagKit

class NewsSourcesViewController: UIViewController {
    
    private var countriesModel: [Country] = []
    private var selectedCountries: [String] = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 2150)
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
            CountryCollectionViewCell.self,
            forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
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
        title = "Select News Source"
        createCountriesModel()
        addSubviews()
        addConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
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
            selectedCountries.append(countriesModel[index].name)
        }
        checkIfselectedCountriesIsEmpty()
        APIManager.shared.selectedCountries = self.selectedCountries
        self.selectedCountries = []
        let vc = HomeViewController()
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    /// Method for checking if user selected any category before proceedeing to the next step.
    private func checkIfselectedCountriesIsEmpty() {
        guard !selectedCountries.isEmpty else {
            let alert = UIAlertController(
                title: "Select country",
                message: "Please select at least one country to continue.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    /// Method for creating country models and storing them in an array for further usage.
    private func createCountriesModel() {
        let countryNames: [String] = Constansts.countrySourceNames
        let countryCodes: [String] = Constansts.countryCodes
        
        for i in 0..<countryNames.count {
            let name = countryNames[i]
            let code = countryCodes[i]
            guard let image = UIImage(named: code.uppercased(), in: FlagKit.assetBundle, compatibleWith: nil) else {
                print("Failed to retrive flag image for country: \(name) with code \(code)")
                return
            }
            
            let country = Country(
                name: name,
                code: code,
                image: image)
            
            countriesModel.append(country)
        }
        print("ok")
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
        contentView.heightAnchor.constraint(equalToConstant: 2150).isActive = true
        
        // CollectionView
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
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


extension NewsSourcesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countriesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CountryCollectionViewCell.identifier,
            for: indexPath) as! CountryCollectionViewCell
        
        cell.configure(with: countriesModel[indexPath.row])
        
        return cell
    }
    
    
}

