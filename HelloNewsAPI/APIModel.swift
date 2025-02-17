//
//  APIModel.swift
//  HelloNewsAPI
//
//  Created by Willy Hsu on 2025/1/13.
//

import Foundation
import Alamofire

class APIModel{
    static var share = APIModel()
    init(){}
    
    private let apiURL = "https://newsapi.org/v2/"
    func queryHeadlinesNews(completion: @escaping(_ data:Data?,_ error:Error?)->()){
        let url = apiURL + "top-headlines?country=us&apiKey=193228d932624f3abafbb45a9bac7853"
        let parameters: Parameters? = nil
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default).response{ response in
            switch response.result{
            case .success(_):
                return completion(response.data, nil)
                
            case .failure(let error):
                return completion(nil, error)
            }
            
        }
    }
    
    func queryAppleNews(completion: @escaping(_ data:Data?,_ error:Error?)->()){
        let url = apiURL + "everything?q=Apple&from=2025-01-15&sortBy=popularity&apiKey=193228d932624f3abafbb45a9bac7853"
        let parameters: Parameters? = nil
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default).response{ response in
            switch response.result{
            case .success(_):
                return completion(response.data, nil)
                
            case .failure(let error):
                return completion(nil, error)
            }
            
        }
    }
}
