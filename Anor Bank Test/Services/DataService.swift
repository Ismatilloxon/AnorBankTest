//
//  NetworkingManager.swift
//  Anor Bank Test
//
//  Created by Ismatilla.adm on 24/06/23.
//

import Foundation
import Combine

// http://api.exchangeratesapi.io/v1/latest?access_key=771758f62e43f9b9d7eb3f702b9b0fc7

final class DataService {
    private let baseAPI = "http://api.exchangeratesapi.io/v1/latest?access_key="
    private let apiKey = "771758f62e43f9b9d7eb3f702b9b0fc7"
    
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    var url: URL {
        URL(string: baseAPI + apiKey)!
    }

    
    func request() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                
                print(output)
                
                guard
                    let response = output.response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300  else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .decode(type: ExchangeRates.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { publisher in
                switch publisher {
                case .finished: print("parsing seccess")
                case .failure(let error): print("parsing failure, \(error)")
                }
            } receiveValue: { value in
                print(value)
                self.cancellable?.cancel()
            }
    }
}


