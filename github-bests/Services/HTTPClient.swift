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
