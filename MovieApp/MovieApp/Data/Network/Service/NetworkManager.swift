//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Jason on 2023/09/05.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager: Gettable {
    
    func loadAPIData<M: Decodable, P: Encodable>(url: URL, parameters: P) -> Single<M> {
        
        return Single<M>.create { single in
            AF.request(url, method: .get, parameters: parameters)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result: M = try self.decoder.decode(M.self, from: data)
                        single(.success(result))
                    } catch {
                        print(DataLoadError.loadFailOfAPIData)
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    private let decoder = JSONDecoder()
}
