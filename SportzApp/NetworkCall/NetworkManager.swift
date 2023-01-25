//
//  NetworkManager.swift
//  SportzApp
//
//  Created by Darshika Patel on 24/01/23.
//

import Foundation

enum UserError: Error {
    case NoDataAvailable
    case CanNotProcessData
}

class NetworkManager {
    static let shared = NetworkManager()
    let session = URLSession.shared
    
    func getAllMatchesData(url: URL, completion: @escaping(Result<MatchDetails, UserError>)->Void) {
        session.dataTask(with: url) {data,response,error in
            do {
                guard data != nil else {
                    completion(.failure(.NoDataAvailable))
                    return
                }
                if let data = data {
                    let jsonData = try JSONDecoder().decode(MatchDetails.self, from: data)
                    completion(.success(jsonData))
                    print(jsonData)
                }
            } catch {
                completion(.failure(.CanNotProcessData))
            }
        }.resume()
    }
}
