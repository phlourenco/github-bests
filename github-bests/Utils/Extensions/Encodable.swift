//
//  Encodable.swift
//  github-bests
//
//  Created by Paulo Lourenço on 04/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toData() -> Data? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return jsonData
        }
        catch {
            print("toData fail!!")
            return nil
        }
    }
    
    func toJSON() -> Dictionary<String, Any>? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! Dictionary<String, Any>
            return dictionary
        }
        catch {
            print("toJSON fail!!")
            return nil
        }
    }
}

