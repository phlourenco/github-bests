//
//  RequestStubs.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 04/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import Swifter

class RequestStubs {
    var server: HttpServer!
    
    private func serverPort() -> Int {
        let deviceName = UIDevice.current.name
        
        if deviceName.contains("Clone") {
            let range = deviceName.range(of: "Clone ")?.upperBound
            let device = deviceName[range! ..< deviceName.index(after: range!)]
            return 8080 + Int(device)!
        }
        
        return 8080
    }
    
    func setupServer() {
        server = HttpServer()
        do {
            let port = serverPort()
            
            try server.start(in_port_t(port))
        } catch {
            print("MERDAAAAAAAAAAA")
        }
    }
    
    func stubRequest(path: String, jsonData: Data) {
        setupServer()
        
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            assertionFailure("Could not convert data to json")
            return
        }
        
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            print("AFFFFFFFFFFFEEEEEEE")
//            return HttpResponse.ok(.json(json as AnyObject))
            return HttpResponse.internalServerError
        }
        
//        server[path] = {
//            print("aaaa")
//            .ok(.htmlBody("You asked for \($0)"))
//        }

        
        server.get[path] = response
    }
}
