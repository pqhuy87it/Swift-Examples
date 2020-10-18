//
//  RoutersProtocol.swift
//  RoutersWithPoP
//
//  Created by Pham Quang Huy on 8/4/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRouter {
    static var basePath: String { get }
}

protocol Routable {
    typealias Parameters = [String: Any]
    var route: String { get set }
    init()
}

extension Routable {
    init() {
        self.init()
    }
}

protocol Readable: Routable {
    
}

extension Readable where Self: Routable {
    static func get(params: String) -> RequestConverter {
        let temp =  Self.init()
        let route = "\(temp.route)\(params)"
        return RequestConverter(method: .get, route: route)
    }
}

protocol Creatable: Routable {
    
}

extension Creatable where Self: Routable {
    static func create(parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)"
        return RequestConverter(method: .post, route: route)
    }
}

protocol Updatable: Routable {
    
}

extension Updatable where Self: Routable {
    static func update(params: String, parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)\(params)"
        return RequestConverter(method: .put, route: route, parameters: parameters)
    }
}

protocol Deletable: Routable {
    
}

extension Deletable where Self: Routable {
    static func delete(params: String) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)\(params)"
        return RequestConverter(method: .delete, route: route)
    }
}

protocol RequestConverterProtocol: URLRequestConvertible {
    
}

struct Router: URLRouter {
    static var basePath: String {
        return "https://dog.ceo"
    }
    
    struct Dog: Readable {
        var route: String = "/api/breeds/list/all"
    }
}

struct RequestConverter: RequestConverterProtocol {
    var method: HTTPMethod
    var route: String
    var parameters: Parameters = [:]
    
    init(method: HTTPMethod, route: String, parameters: Parameters = [:]) {
        self.method = method
        self.route = route
        self.parameters = parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.basePath.asURL()
        let urlRequest =  URLRequest(url: url.appendingPathComponent(route))
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
