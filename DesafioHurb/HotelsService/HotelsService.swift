//
//  HotelsService.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation
import Alamofire

fileprivate protocol HotelsServiceProtocol {
    func fetchHotels(router: HotelsRouter, completion: @escaping (Result<HotelsModel>) -> Void)
}

public struct HotelsService: HotelsServiceProtocol {
    func fetchHotels(router: HotelsRouter, completion: @escaping (Result<HotelsModel>) -> Void) {
        Network.manager.request(router).validate(statusCode: 200..<300).responseJSON { response -> Void in
            switch response.result {
            case .success(let value):
                do {
                    let hotels = try JSONDecoder().decode(HotelsModel.self, withJSONObject: value, options: [])
                    completion(Result.success(hotels))
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
