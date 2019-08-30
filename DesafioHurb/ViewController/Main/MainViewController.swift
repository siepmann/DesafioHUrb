//
//  ViewController.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var presenter: MainPresenter!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var reloadAction: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(delegate: self)
        activityIndicator.hidesWhenStopped = true
        
        tableView.registerTableViewCell(HotelTableViewCell.self)
        
        presenter.fetchHotels(from: "gramado")
    }
    
    @IBAction func redoSearch(_ sender: AnyObject) {
        activityIndicator.startAnimating()
        tableView.isHidden = true
        errorView.isHidden = true
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotelTableViewCell.reusableIdentifier, for: indexPath) as! HotelTableViewCell
        if let hotel = presenter.getHotelBy(indexPath: indexPath) {
            cell.setupWith(hotel: hotel)
        } else {
            cell.setupErrorCell()
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "section \(section)"
//    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension MainViewController: MainViewProtocol {
    func loadingState() {
        tableView.isHidden = true
        errorView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func didFetchWithSuccess() {
        tableView.isHidden = false
        errorView.isHidden = true
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func didFetchWithError(error: Error) {
        tableView.isHidden = true
        errorView.isHidden = false
        activityIndicator.stopAnimating()
    }
}
