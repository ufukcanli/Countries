//
//  CountriesViewController+Ext.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

// MARK: - ConfigureUI
extension CountriesViewController {
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
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
