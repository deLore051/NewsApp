//
//  ViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 29.10.21..
//

import UIKit

class TopHeadlinesViewController: UIViewController {
    
    private var articles: [Article] = []
    private var articlesToShow: [Article] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(
            ArticlesPreviewTableViewCell.self,
            forCellReuseIdentifier: ArticlesPreviewTableViewCell.identifier)
        tableView.clipsToBounds = true
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        addConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        getArticles()
    }
    
    private func getArticles() {
        ArticlesManager.shared.getTopHeadlines()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.articlesToShow = ArticlesManager.shared.articlesToShow
            print(self.articlesToShow.count)
            self.tableView.reloadData()
        }
    }

    private func addConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    

}

//MARK: - UITableViewDataSource_Delegate

extension TopHeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticlesPreviewTableViewCell.identifier,
            for: indexPath) as! ArticlesPreviewTableViewCell
        let article = articlesToShow[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("open new vc")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
