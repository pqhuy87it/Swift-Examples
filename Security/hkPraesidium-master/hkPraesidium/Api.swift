//
//  Api.swift
//  hkPraesidium
//
//  Created by Anderson Santos Gusmao on 06/10/17.
//  Copyright © 2017 Heuristisk. All rights reserved.
//

import Foundation

class Api: NSObject, URLSessionDelegate {
    
    static var isSSLPinningEnabled = false
    
    func authenticate(userId: String, password: String, callback: @escaping (_ output: String, _ hasError: Bool) -> Void) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        
        var request = URLRequest(url: URL(string: "https://floating-stream-25740.herokuapp.com/authentication/login")!)
        request.httpMethod = "POST"
        let postString = "id=\(userId)&password=\(password)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                callback(error?.localizedDescription ?? "", true)
                print(error?.localizedDescription ?? "")
                
                return
            }
            
            let responseString = String(data: data, encoding: .utf8) ?? ""
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                callback(responseString, true)
                print(responseString)
            } else {
                callback(responseString, false)
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        
        if !Api.isSSLPinningEnabled {
            let credential:URLCredential = URLCredential(trust: serverTrust!)
            completionHandler(.useCredential, credential)
        } else {
            // Set SSL policies for domain name check
            let policies = NSMutableArray();
            policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString)))
            SecTrustSetPolicies(serverTrust!, policies);
            
            // Evaluate server certificate
            var result: SecTrustResultType = SecTrustResultType(rawValue: 0)!
            SecTrustEvaluate(serverTrust!, &result)
            let isServerTrusted:Bool = result == SecTrustResultType.unspecified || result ==  SecTrustResultType.proceed
            
            // Get local and remote cert data
            let remoteCertificateData:NSData = SecCertificateCopyData(certificate!)
            let pathToCert = Bundle.main.path(forResource: "herokuapp.com", ofType: "cer")
            let localCertificate:NSData = NSData(contentsOfFile: pathToCert!)!
            
            if (isServerTrusted && remoteCertificateData.isEqual(to: localCertificate as Data)) {
                let credential:URLCredential = URLCredential(trust: serverTrust!)
                completionHandler(.useCredential, credential)
            } else {
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }
    }
}
