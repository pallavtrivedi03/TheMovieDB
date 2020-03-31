//
//  HomeViewController.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        homeViewModel.reloadTableData = {
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
        }
        
        setupViews()
        homeViewModel.fetchTrendingMovies()
        
    }

    func setupViews() {
        moviesTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.movieCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.movieCell)
        moviesTableView.estimatedRowHeight = 230
        moviesTableView.rowHeight = UITableView.automaticDimension
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        searchBar.delegate = self
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstants.ViewIdentifiers.detailView) as? DetailViewController
        detailVC?.detailViewModel.movie = homeViewModel.filteredMovies[indexPath.row]
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.ViewIdentifiers.movieCell, for: indexPath) as? MovieTableViewCell
        cell?.titleLabel?.text = homeViewModel.filteredMovies[indexPath.row].title ?? ""
        cell?.releaseDateLabel?.text = Helper.getFormattedDateString(dateString: homeViewModel.filteredMovies[indexPath.row].release_date ?? "")
        var posterUrl = AppConstants.API.imageBasePath.appending(AppConstants.API.posterSize)
        posterUrl = posterUrl.appending(homeViewModel.filteredMovies[indexPath.row].poster_path ?? "")
        cell?.posterImageView.kf.setImage(with: URL(string: posterUrl))
        cell?.selectionStyle = .none
        if indexPath.row == (homeViewModel.filteredMovies.count ) - 4 {
            homeViewModel.fetchTrendingMovies()
        }
        return cell!
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var queryString = ""
        if range.length == 1 && string.count == 0 {
            queryString = String((textField.text ?? "").dropLast())
        }
        else {
            queryString = (textField.text ?? "").appending(string)
        }
        homeViewModel.searchMovie(queryString: queryString.lowercased())
        return true
    }
}
