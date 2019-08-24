//
//  CustomServerTrustPolicyManager.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit
import Alamofire

class CustomServerTrustPolicyManager: ServerTrustPolicyManager {
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        // Check if we have a policy already defined, otherwise just kill the connection
        if let policy = super.serverTrustPolicy(forHost: host) {
            print(policy)
            return policy
        } else {
            return .customEvaluation({ (_, _) -> Bool in
                return false
            })
        }
    }
}
