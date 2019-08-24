//
//  APIFactory.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

public struct APIFactory {
    private init() { }
    public static let shared = APIFactory()
    
    public var hotelsService = HotelsService()
}
