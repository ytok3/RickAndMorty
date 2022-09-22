//
//  ServiceManager.swift
//  RickAndMortyApp
//
//  Created by Yasemin TOK on 22.09.2022.
//

import Foundation
import Alamofire

typealias resultClosure<T: Codable> = (Result<T, Error>) -> Void

enum HttpError: Error {
    case badRequest, badURL, errorDecodingData, invalidURL, badResponse
}

protocol ServiceManagerProtocol: AnyObject {
    func fetch<T: Codable>(url: URL, completion: @escaping resultClosure<T>)
}

class ServiceManager: ServiceManagerProtocol {
    
    // MARK: Properties
    
    private var afSession: Session
    
    // MARK: Init
    
    init(afSession: Session) {
        self.afSession = afSession
    }
    
    func fetch<T>(url: URL, completion: @escaping resultClosure<T>) where T : Decodable, T : Encodable {
        
        afSession.request(url, method: .get).validate().responseDecodable(of: T.self) { results in
            
            if results.response?.statusCode == 400 {
                return completion(.failure(HttpError.badRequest))
            }
            
            guard let model = results.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            
            completion(.success(model))
        }
    }
}
