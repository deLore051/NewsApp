//
//  CustomSourcesTableViewCell.swift
//  NewsApp
//
//  Created by Stefan Dojcinovic on 3.11.21..
//

import UIKit

class CustomSourcesTableViewCell: UITableViewCell {

    static let identifier = "CustomSourcesTableViewCell"
    
    private let sourceNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(sourceNameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        sourceNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        sourceNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        sourceNameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        sourceNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceNameLabel.text = nil
    }
    
    public func configure(with name: String) {
        self.sourceNameLabel.text = name
    }
    
    public func getLabelTitle() -> String {
        guard let title = self.sourceNameLabel.text else {
            return "default"
        }
        return title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
        
    }
    
    
    
}
