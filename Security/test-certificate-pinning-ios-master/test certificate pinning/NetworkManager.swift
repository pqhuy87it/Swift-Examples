//
//  NetworkManager.swift
//  test certificate pinning
//
//  Created by Antonio Chiappetta on 21/02/2018.
//  Copyright © 2018 Antonio Chiappetta. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let afManager: SessionManager!
    
    private init() {
        afManager = SessionManager(
            configuration: URLSessionConfiguration.default,
            delegate: SessionDelegate(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies:
                [
                    "it.linkedin.com": ServerTrustPolicy.pinCertificates(
                        certificates: ServerTrustPolicy.certificates(),
                        validateCertificateChain: true,
                        validateHost: true
                    )
                ]
            )
        )
        // Check if the certificates found among the app resources (currently there are 4 certificates exported in DER format and with both .cer and .crt extension) are converted into SecCertificate
        // If the array is empty, no certificate has been converted (i.e. none of them will be used for certificate pinning against server certificate)
        let certs = ServerTrustPolicy.certificates()
        print(certs)
    }
    
    func connectToApple() {
        afManager.request("it.linkedin.com", method: .get, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            if let error = dataResponse.error {
                print(error)
            }
            if let data = dataResponse.data {
                print(data)
            }
        }
    }
    
}
