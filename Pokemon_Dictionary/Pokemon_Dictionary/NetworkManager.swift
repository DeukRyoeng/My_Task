//
//  NetworkManager.swift
//  Pokemon_Dictionary
//
//  Created by 이득령 on 8/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { observer in
            let session = URLSession(configuration: .default)
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                
                if let error = error {
                    observer(.failure(error))
                    return
                }
            }
        }
    }
}
q
