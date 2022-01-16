//
//  FavoritesViewController+Ext.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

// MARK: - ConfigureUI
extension FavoritesViewController {
    
    func configureEmptyStateLabel() {
        tableView.addSubview(emptyStateLabel)
        
        let emptyStateText = """
                             🧐 Looks like you don't have
                                any favorite country yet!
                             """
        
        emptyStateLabel.text = emptyStateText
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100),
            emptyStateLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
    func configureActivityIndicatorView() {
        tableView.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 150),
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
        ])
    }
}
