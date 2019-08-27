//
//  MainPresenter.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

class MainPresenter {
    weak var delegate: MainViewProtocol?
    private let maxNumberOfStars = 5
    private var numberOfSections = 0
    
    private var groupedHotels: Dictionary<Int?, [Hotel]>? {
        didSet {
            guard let keys = groupedHotels?.keys else { return }
            numberOfSections = keys.count
        }
    }
    
    init(delegate: MainViewProtocol) {
        self.delegate = delegate
    }
    
    func fetchHotels(from location: String) {
        let router = HotelsRouter.getHotelsFor(city: location, page: 1)
        let service = APIFactory.shared.hotelsService
        
        service.fetchHotels(router: router) { [weak self] (result: Result<HotelsModel>) in
            switch result {
            case .success(let value):
                if let hotels = value.hotels {
                    //Group Hotels by stars
                    self?.groupedHotels = Dictionary(grouping: hotels, by: { $0.stars })
                    self?.delegate?.didFetchWithSuccess()
                } else {
                    self?.delegate?.didFetchWithError(error: NSError(domain: "Failed to parse data", code: -1, userInfo: nil))
                }
            case .failure(let error):
                self?.delegate?.didFetchWithError(error: error)
            }
        }
    }
    
    func getHotelBy(indexPath: IndexPath) -> Hotel? {
        let currentSection = maxNumberOfStars - indexPath.section
        let currentHotelPosition = indexPath.row
        
        return groupedHotels?[currentSection]?[currentHotelPosition]
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        let currentSection = maxNumberOfStars - section
        guard let hotels = groupedHotels, let count = hotels[currentSection]?.count else { return 0 }
        
        return count
    }
    
    func getNumberOfSection() -> Int {
        return numberOfSections
    }
}
