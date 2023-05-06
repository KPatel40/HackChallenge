//
//  NetworkManager.swift
//  khp42_p7
//
//  Created by Krishna Patel on 4/23/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getAllMessages(completion: @escaping ([VinylData]) -> Void) {
        var url = URL(string: "http://34.86.211.208/api/vinyls/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(returnList.self, from: data)
                    completion(response.vinyls)
                }
                catch (let error) {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
