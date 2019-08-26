//
//  ViewController.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let maxNumberOfStars = 5
    private var numberOfSections = 0
    
    private var groupedHotels: Dictionary<Int?, [Hotel]>? {
        didSet {
            guard let keys = groupedHotels?.keys else { return }
            numberOfSections = keys.count
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let router = HotelsRouter.getHotelsFor(city: "gramado", page: 1)
        let service = APIFactory.shared.hotelsService
        
        
        service.fetchHotels(router: router) { [weak self] (results: Result<HotelsModel>) in
            guard let hotels = results.value?.results else { return }
            self?.groupedHotels = Dictionary(grouping: hotels, by: { $0.stars })
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
}

