//
//  ViewController.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let router = HotelsRouter.getHotelsFor(city: "gramado", page: 1)
        let service = APIFactory.shared.hotelsService
        
        
        service.fetchHotels(router: router) { (results: Result<HotelsModel>) in
            print(results)
        }
    }


}

