//
//  NewsNetwork.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 02/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import Moya

let newsNetworkProvider = MoyaProvider<NewsNetwork>()

enum NewsNetwork{
    case news(q: String, from: String, sortBy: String, apiKey: String)
}

extension NewsNetwork: TargetType{
    var baseURL: URL {
        guard let url = URL(string: "http://newsapi.org") else {
            fatalError("base url couldn't be configure")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .news:
            return "/v2/everything"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .news:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .news(let q, let from, let sortBy, let apiKey):
            return .requestParameters(parameters: ["q": q, "from": from, "sortBy": sortBy, "apiKey": apiKey], encoding: URLEncoding.default)
        }
    }
    
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
