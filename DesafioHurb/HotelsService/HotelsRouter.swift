//
//  HotelsRouter.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation
import Alamofire

enum HotelsRouter: APIRouter {
    case getHotelsFor(city: String, page: Int)
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        return APIConfig.searchPath
    }
    
    var parameters: APIParams {
        switch self {
        case .getHotelsFor(let city, let page):
            return [
                "q" : city,
                "page" : page
            ]
        }
    }
}
