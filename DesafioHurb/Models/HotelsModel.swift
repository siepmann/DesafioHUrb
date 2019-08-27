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
    let stars: Int?
    private let address: Address?
    private let amenities: [Amenity]?
    private let price: ResultPrice?
    private let gallery: [Gallery]?
    
    enum CodingKeys: String, CodingKey {
        case sku, name, id, stars
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
        guard let price = self.price?.amount else { return "" }
        
        let formatter = NumberFormatter()
        formatter.currencyCode = "BRL"
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

// MARK: - Amenity
struct Amenity: Codable {
    let name: String?
    let category: String?
}

// MARK: - Gallery
struct Gallery: Codable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

// MARK: - ResultPrice
struct ResultPrice: Codable {
    let amount: Double?
    
    enum CodingKeys: String, CodingKey {
        case amount
    }
}
