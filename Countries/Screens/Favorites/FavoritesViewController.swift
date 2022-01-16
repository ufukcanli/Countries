//
//  FavoritesViewController.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

final class FavoritesViewController: UITableViewController {
    
    private(set) lazy var activityIndicatorView = UIActivityIndicatorView(style: .medium)
    private(set) lazy var emptyStateLabel = UILabel()
    
    private let viewModel: FavoritesViewModel!

    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCellViewModel.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureEmptyStateLabel()
        configureActivityIndicatorView()
        viewModel.fetchFavorites()
    }
}

// MARK: - FavoritesViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func didFinishLoading() {
        DispatchQueue.main.async { self.activityIndicatorView.stopAnimating() }
    }
    
    func didFinishFetching() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func didFinishWithError() {
        presentAlertOnMainThread(title: "Ooops!", message: viewModel.errorMessage, buttonTitle: "OK")
    }
}


// MARK: - UITableViewDataSource
extension FavoritesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyStateLabel.isHidden = viewModel.shouldShowEmptyState
        return viewModel.numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellViewModel.reuseIdentifier, for: indexPath) as! CountryCell
        let country = viewModel.cellForRowAt(indexPath: indexPath)
        cell.populateCell(with: CountryCellViewModel(country: country))
        return cell
    }
}


// MARK: - UITableViewDelegate
extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let code = viewModel.cellForRowAt(indexPath: indexPath).code
        let destinationViewModel = DetailViewModel(code: code)
        let destinationViewController = DetailViewController(viewModel: destinationViewModel)
        destinationViewController.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .destructive, title: "Mark as unfavorite") { [weak self] _, _, completion in
            self?.viewModel.removeCountry(at: indexPath)
            self?.activityIndicatorView.startAnimating()
            self?.tableView.reloadData()
            completion(true)
        }
        favoriteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
