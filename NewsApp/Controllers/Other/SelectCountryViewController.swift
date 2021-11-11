//
//  SelectCountryViewController.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 2.11.21..
//

import UIKit
import FlagKit

class SelectCountryViewController: UIViewController {
    
    private var countries: [Country] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        tableView.backgroundColor = .systemBackground
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Country"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        addConstraints()
        createCountriesModel()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        // TableView
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    /// Method for creating country models and storing them in an array for further usage.
    private func createCountriesModel() {
        let countryNames: [String] = Constansts.countrySourceNames
        let countryCodes: [String] = Constansts.countryCodes
        
        for i in 0..<countryNames.count {
            let name = countryNames[i]
            let code = countryCodes[i]
            guard let image = UIImage(named: code.uppercased(), in: FlagKit.assetBundle, compatibleWith: nil) else {
    
                return
            }
            let country = Country(name: name, code: code, image: image)
            countries.append(country)
        }
        
    }

}

//MARK: - UITableViewDataSource_Delegate

extension SelectCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CountryTableViewCell.identifier,
            for: indexPath) as! CountryTableViewCell
        cell.configure(with: countries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        AppSettings.shared.selectedCountryCode = cell.getCountryCode()
        let vc = SelectCategoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
