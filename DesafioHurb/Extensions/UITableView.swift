//
//  UITableView.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

extension UITableView {
    func registerTableViewCell<T: ReusableCellIdentifiable>(_ cell: T.Type) {
        register(
            UINib(
                nibName: String(describing: cell),
                bundle: nil
            ),
            forCellReuseIdentifier: T.reusableIdentifier
        )
    }
    
    func dequeueReusableCell<T: ReusableCellIdentifiable>(forIndexPath indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
