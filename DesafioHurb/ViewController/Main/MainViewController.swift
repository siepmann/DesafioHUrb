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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        presenter = MainPresenter(delegate: self)
    }
    
    
}

extension MainViewController: MainViewProtocol {
    func didFetchWithSuccess() {
        
    }
    
    func didFetchWithError(error: Error) {
        
    }
}
