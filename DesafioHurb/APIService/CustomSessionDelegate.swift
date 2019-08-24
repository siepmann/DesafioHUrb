//
//  CustomSessionDelegate.swift
//  DesafioHurb
//
//  Created by Guilherme Siepmann on 22/08/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation
import Alamofire

class CustomSessionDelegate: SessionDelegate {
    override init() {
        super.init()
        
        // Alamofire uses a block var here
        sessionDidReceiveChallengeWithCompletion = { session, challenge, completion in
            guard let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 else {
                // This case will probably get handled by ATS, but still...
                completion(.cancelAuthenticationChallenge, nil)
                return
            }
            
            // compare the public keys
            if let serverCertificate = SecTrustGetCertificateAtIndex(trust, 0),
                let serverCertificateKey = CustomSessionDelegate.publicKey(for: serverCertificate) {
                if ServerTrustPolicy.publicKeys().contains(serverCertificateKey) {
                    completion(.useCredential, URLCredential(trust: trust))
                    return
                }
            }
            
            completion(.cancelAuthenticationChallenge, nil)
        }
    }
    
    
    // Implementation from Alamofire
    private static func publicKey(for certificate: SecCertificate) -> SecKey? {
        var publicKey: SecKey?
        
        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)
        
        if let trust = trust, trustCreationStatus == errSecSuccess {
            publicKey = SecTrustCopyPublicKey(trust)
        }
        
        return publicKey
    }
    
}
