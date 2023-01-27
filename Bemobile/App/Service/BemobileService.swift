//
//  BemobileService.swift
//  Bemobile
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

protocol BemobileServiceProtocol {
    func fetch<T: Decodable>(_ type: BemobileServiceType, completion: @escaping (ResultResponse<T>) -> Void)
}

final class BemobileService: BemobileServiceProtocol {
    
    func fetch<T: Decodable>(_ type: BemobileServiceType, completion: @escaping (ResultResponse<T>) -> Void) {
        guard let url = URL(string: type.urlString) else {
            completion(.failure(.badURL))
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.init(message: error?.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.invalidJSON))
                return
            }
            
            completion(.success(decoded))
        }
        task.resume()
    }
    
}
