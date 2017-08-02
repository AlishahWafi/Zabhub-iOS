//
//  Request.swift
//  zabhub
//
//  Created by ZabHub Team on 5/13/17.
//  Copyright © 2017 Talha Ashraf. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_Synchronous


class Request {
    var url: String
    var parameters: [String: String]
    
    init(url: String, parameters: [String: String]) {
        self.url = url
        self.parameters = parameters
    }
    
    func getData() -> [String: Any] {
        var data = [String: Any]()
        let response = Alamofire.request(self.url, method: .post, parameters: self.parameters, encoding: JSONEncoding.default).responseJSON (options: .allowFragments)
        if response.response?.statusCode == 200 {
            data = (response.result.value as! [String: Any])
        } else {
            print("Error with response status: \(response.response?.statusCode)")
        }
        return data
    }
}
