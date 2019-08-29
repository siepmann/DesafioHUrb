//
//  UIImageView.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func setImageWithUrl(_ url: URL?,  placeHolder: String = "") {
        self.kf.setImage(with: url,
                         placeholder: Image(named: placeHolder),
                         options: [.transition(.fade(1)), .cacheMemoryOnly]
                         )
    }
}
