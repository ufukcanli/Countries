//
//  DetailViewController.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    private(set) lazy var activityIndicatorView = UIActivityIndicatorView(style: .medium)
    private(set) lazy var favoriteButton = UIBarButtonItem()
    private(set) lazy var flagImageView = UIImageView()
    private(set) lazy var countryCodeLabel = UILabel()
    private(set) lazy var moreInfoButton = UIButton()
    
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel = DetailViewModel(code: "US")) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureFlagImageView()
        configureCountryCodeLabel()
        configureMoreInfoButton()
        configureNavigationBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureActivityIndicatorView()
        viewModel.fetchCountry()
    }
    
    @objc func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        print("didTapFavoriteButton")
        viewModel.didTapFavoriteButton()
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {

    func didFinishChecking(_ isFavorited: Bool) {
        DispatchQueue.main.async {
            let name = isFavorited ? "star.fill" : "star"
            self.configureNavigationBarButton(with: name)
            print(isFavorited, "didFinishChecking")
        }
    }
    
    func didFinishLoading() {
        DispatchQueue.main.async { self.activityIndicatorView.stopAnimating() }
    }
    
    func didFinishFetching(_ country: CountryDetail) {
        DispatchQueue.main.async {
            let url = URL(string: country.flag)!
            self.flagImageView.sd_setImage(with: url)
            let attributedText = self.createAttributedString("Country Code: ", country.code)
            self.countryCodeLabel.attributedText = attributedText
        }
    }
}
