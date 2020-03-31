//
//  DetailViewController.swift
//  TheSchoolOfRock
//
//  Created by Pallav Trivedi on 29/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewModel.reloadTableData = {
            DispatchQueue.main.async { [weak self] in
                self?.detailsTableView.reloadData()
            }
        }
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = detailViewModel.movie?.title ?? ""
        self.detailsTableView.reloadData()
        self.detailViewModel.fetchCast()
        self.detailViewModel.fetchSimilar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupViews() {
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.posterViewCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.posterViewCell)
        detailsTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.sysnopsisCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.sysnopsisCell)
        detailsTableView.register(UINib(nibName: AppConstants.ViewIdentifiers.castCell, bundle: nil), forCellReuseIdentifier: AppConstants.ViewIdentifiers.castCell)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailViewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailViewModel.rows[indexPath.row] ?? "", for: indexPath) as? PosterTableViewCell
            var posterUrl = AppConstants.API.imageBasePath.appending(AppConstants.API.posterSize)
            posterUrl = posterUrl.appending(detailViewModel.movie?.poster_path ?? "")
            cell?.posterImageView.kf.setImage(with: URL(string: posterUrl))
            self.view.backgroundColor = cell?.posterImageView.image?.averageColor
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailViewModel.rows[indexPath.row] ?? "", for: indexPath) as? SynopsisTableViewCell
            cell?.titleLabel.text = detailViewModel.movie?.title ?? ""
            cell?.subtitleLabel.text = Helper.getFormattedDateString(dateString: detailViewModel.movie?.release_date ?? "")
            cell?.synopsisLabel.text = detailViewModel.movie?.overview ?? ""
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailViewModel.rows[indexPath.row] ?? "", for: indexPath) as? CastTableViewCell
            cell?.cellType = .cast
            cell?.titleLabel.text = "Cast"
            cell?.cast = detailViewModel.cast?.cast
            cell?.castCollectionView.reloadData()
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailViewModel.rows[indexPath.row] ?? "", for: indexPath) as? CastTableViewCell
            cell?.cellType = .similar
            cell?.titleLabel.text = "Similar Movies"
            cell?.similar = detailViewModel.similar?.results
            cell?.castCollectionView.reloadData()
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    
}
