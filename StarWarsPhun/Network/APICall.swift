//
//  APIService.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/8/22.
//

import Foundation
import UIKit

public enum HTTPMethod: String {
    case get = "GET"
}

class APICall {
    
    //MARK: - Variables
    let starWarsURL = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    private let urlSession = URLSession.shared
    
    //MARK: - Helper
    func fetchStarWarsData(completion: @escaping ([StarWarsData]?, Error?) -> Void) {
        //Fetches Star Wars Data from API
        guard let url = URL(string: starWarsURL) else {return}
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 7)
        
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let swCodeable = try decoder.decode([StarWarsData].self, from: data)
                completion(swCodeable, nil)
            }
            catch let err {
                print(err)
            }
        }.resume()
    }
    
    func fetchStarWarsImage(starWarsURL: String, completion: @escaping (UIImage?) -> Void) {
        //Fetches Star Wars Image from API
        guard let url = URL(string: starWarsURL) else {return}
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 7)
        
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print(error)
            }
        }.resume()
    
    }
}
