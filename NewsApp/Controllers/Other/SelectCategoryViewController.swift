//
//  SelectCategoryViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Category"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        addConstraints()
        getCategories()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getCategories() {
        ArticlesManager.shared.getCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
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

extension SelectCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticlesManager.shared.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let category = ArticlesManager.shared.categories[indexPath.row]
        cell.textLabel?.text = category
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath),
              let category = cell.textLabel?.text else {
            return
        }
        APIManager.shared.selectedCategory = category
        let vc = SelectSourcesViewController()
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

