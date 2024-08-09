//
//  NetworkManager.swift
//  Pokemon_DrawingBook
//
//  Created by 이득령 on 8/4/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    var id: Int?
    
    func fetch<T: Decodable>(url: URL) -> Single<T> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                guard let data = data else {
                    single(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    single(.success(decodedData))
                } catch {
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
