//
//  ReusableCellIdentifiable.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableCellIdentifiable {
    static var reusableIdentifier: String { get }
}

extension ReusableCellIdentifiable {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableCellIdentifiable {}
extension UICollectionReusableView: ReusableCellIdentifiable {}

