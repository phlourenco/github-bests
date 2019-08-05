//
//  HTTPClient.swift
//  github-bests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class HTTPClient {

    enum Errors: Error {
        case unknownStatusCode
        case parseError
        case errorStatusCode(Int)
        case invalidURL
    }

    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parseAs object: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Promise<T> {
        return Promise<T> { seal in
            guard let url = URL(string: url) else {
                seal.reject(Errors.invalidURL)
                return
            }

            Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: { (response) in
                if let error = response.error {
                    seal.reject(error)
                    return
                }

                guard let statusCode = response.response?.statusCode else {
                    seal.reject(Errors.unknownStatusCode)
                    return
                }

                switch statusCode {
                case 200..<299:
                    if let parsedObj = response.data?.parse(asObject: T.self, usingKeyDecodingStrategy: keyDecodingStrategy) {
                        seal.fulfill(parsedObj)
                    } else {
                        seal.reject(Errors.parseError)
                    }
                default:
                    seal.reject(Errors.errorStatusCode(statusCode))
                }
            })
        }

    }

}


//class HTTPClient {
//
//    enum Errors: Error {
//        case unknownStatusCode
//        case parseError
//        case errorStatusCode(Int)
//        case invalidURL
//    }
//
//    enum MethodType: String {
//        case get = "GET"
//        case post = "POST"
//    }
//
//
//    func request<T: Decodable>(url: String, method: MethodType, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parseAs object: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Promise<T> {
//
//        var completeURL = URLComponents(string: url)!
//        if let params = parameters {
//            completeURL.queryItems = []
//            for (name, value) in params {
//                completeURL.queryItems?.append(URLQueryItem.init(name: name, value: "\(value)"))
//            }
//        }
//
//        var urlRequest = URLRequest(url: completeURL.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
//
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.httpMethod = method.rawValue
//
//        return Promise<T> { seal in
//
//            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//                if let error = error {
//                    seal.reject(error)
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse else {
//                    seal.reject(Errors.unknownStatusCode)
//                    return
//                }
//
//                switch response.statusCode {
//                case 200..<299:
//                    if let parsedObj = data?.parse(asObject: T.self, usingKeyDecodingStrategy: keyDecodingStrategy) {
//                        seal.fulfill(parsedObj)
//                    } else {
//                        seal.reject(Errors.parseError)
//                    }
//                default:
//                    seal.reject(Errors.errorStatusCode(response.statusCode))
//                }
//            }
//            task.resume()
//        }
//    }
//
//}
