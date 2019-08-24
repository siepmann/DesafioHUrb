//
//  HotelsModel.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

// MARK: - Hotels
struct HotelsModel: Codable {
    let results: [Hotel]?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let count: Int?
    let firstPage, nextPage: String?
    let previousPage: String?
    let lastPage: String?
}

// MARK: - Result
struct Hotel: Codable {
    let sku: String?
    let id: String?
    let name: String?
    private let address: Address?
    private let amenities: [AmenityElement]?
    private let price: ResultPrice?
    private let gallery: [Gallery]?
    
    enum CodingKeys: String, CodingKey {
        case sku, name, id
        case address, amenities, price, gallery
    }
    
    func spotlightImage() -> URL? {
        guard let imageUrlString = self.gallery?.first?.url,
            let imageURL = URL(string: imageUrlString) else { return nil }
        return imageURL
    }
    
    func listAmenities() -> String {
        return self.amenities?.compactMap({ $0.name }).prefix(3).joined(separator: ", ") ?? ""
    }
    
    func locationDescription() -> String {
        guard let address = self.address else { return "" }
        return "\(address.city ?? ""), \(address.state ?? "")"
    }
    
    func formattedPrice() -> String {
        guard let currency = self.price?.currency,
            let price = self.price?.currentPrice else { return "" }
        
        
        let formatter = NumberFormatter()
        formatter.currencyCode = currency
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$ "
        formatter.minimumFractionDigits = "\(price)".contains(".00") ? 0 : 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}

// MARK: - Address
struct Address: Codable {
    let city: String?
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case city, state
    }
}

// MARK: - AmenityElement
struct AmenityElement: Codable {
    let name: String?
    let category: String?
}

// MARK: - Gallery
struct Gallery: Codable {
    let galleryDescription: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case galleryDescription = "description"
        case url
    }
}

// MARK: - ResultPrice
struct ResultPrice: Codable {
    let currency: String?
    let currentPrice, amount: Double?
    
    enum CodingKeys: String, CodingKey {
        case currency, amount
        case currentPrice = "current_price"
    }
}
