//
//  MainView.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 27/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

protocol MainViewProtocol: NSObjectProtocol {
    func didFetchWithSuccess()
    func didFetchWithError(error: Error)
}
