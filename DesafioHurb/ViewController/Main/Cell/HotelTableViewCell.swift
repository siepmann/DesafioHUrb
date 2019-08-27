//
//  HotelTableViewCell.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {
    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var footerView: UIView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var amenitiesLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerImageView.image = nil
        priceLabel.text = ""
        amenitiesLabel.text = ""
        locationLabel.text = ""
        nameLabel.text = ""
    }

    func setupWith(hotel: Hotel) {
        
    }
    
    func setupErrorCell() {
        
    }
}
