//
//  SelectSourcesViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import UIKit

class SelectSourcesViewController: UIViewController {
    
    private var sourcesModel: [NewsSource] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.backgroundColor = .systemBackground
        tableView.register(CustomSourcesTableViewCell.self,
                           forCellReuseIdentifier: CustomSourcesTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Sources"
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapDoneButton(sender:)))
        view.addSubview(tableView)
        addConstraints()
        getSources()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func didTapDoneButton(sender _: UIBarButtonItem) {
        let vc = TopHeadlinesViewController()
        vc.title = "Top Headlines"
//        let navVC = UINavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getSources() {
        let country = APIManager.shared.selectedCountryCode
        let category = APIManager.shared.selectedCategory
        ArticlesManager.shared.getSources(for: country, category: category)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
        
    private func addConstraints() {
        // TableView
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.navigationItem.largeTitleDisplayMode = .always
        coordinator.animate(
            alongsideTransition: { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.navigationBar.sizeToFit()
            },
            completion: nil)
    }

}

//MARK: - UITableViewDataSource_Delegate

extension SelectSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticlesManager.shared.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomSourcesTableViewCell.identifier,
            for: indexPath) as! CustomSourcesTableViewCell
        self.sourcesModel = ArticlesManager.shared.sources
        let source: NewsSource? = sourcesModel[indexPath.row]
        if let source = source {
            cell.configure(with: source.name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomSourcesTableViewCell
        let sourceName = cell.getLabelTitle()
        ArticlesManager.shared.selectedSources.append(sourceName)
        cell.isSelected = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        print(ArticlesManager.shared.selectedSources)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomSourcesTableViewCell
        let sourceName = cell.getLabelTitle()
        let index = checkIfSourceExistsInArray(source: sourceName)
        if index != -1 {
            ArticlesManager.shared.selectedSources.remove(at: index)
        }
        cell.isSelected = false
        if ArticlesManager.shared.selectedSources.count == 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        print(ArticlesManager.shared.selectedSources)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    private func checkIfSourceExistsInArray(source: String) -> Int {
        let selectedSources = ArticlesManager.shared.selectedSources
        for i in 0..<selectedSources.count {
            if source == selectedSources[i] {
                return i
            }
        }
        return -1
    }
    
}
