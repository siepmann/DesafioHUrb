//
//  APIRouter.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Alamofire

typealias APIParams = [String : Any]

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding? { get }
    var parameters: APIParams { get }
    var path: String { get }
    var baseUrl: String { get }
}

extension APIRouter {
    var encoding: Alamofire.ParameterEncoding? {
        return Alamofire.URLEncoding.default
    }
    
    var parameters: APIParams {
        return APIParams()
    }
    
    var baseUrl: String {
        return APIConfig.baseApiUrl
    }
}

extension APIRouter {
    
    public func asURLRequest() throws -> URLRequest {
        let baseURL = NSURL(string: baseUrl)
        let mutableURLRequest = NSMutableURLRequest(url: baseURL!.appendingPathComponent(path)!)
        
        mutableURLRequest.httpMethod = method.rawValue
        
        mutableURLRequest.timeoutInterval = 15.0
        
        if parameters.isEmpty {
            return mutableURLRequest as URLRequest
        } else {
            if let encoding = encoding {
                return try encoding.encode(mutableURLRequest as URLRequest, with: parameters)
            }
        }
        
        return mutableURLRequest as URLRequest
    }
}
