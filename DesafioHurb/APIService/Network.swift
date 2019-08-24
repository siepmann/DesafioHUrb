//
//  Network.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation
import Alamofire

public final class Network {
    private init () {}
    
    public static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.httpAdditionalHeaders = [ "Accept-Encoding": "gzip;q=1.0,compress;q=0.5" ]
        
        
        let customSessionDelegate = CustomSessionDelegate()
        let manager = Alamofire.SessionManager(configuration: configuration,
                                               delegate: customSessionDelegate,
                                               serverTrustPolicyManager: CustomServerTrustPolicyManager( policies: [:] ))
        return manager
    }()
}
