//
//  NetworkingManager.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import Foundation
import Combine

final class DataService {
    
    // MARK: Private PROPERTIES
    private let baseUrl = "https://v6.exchangerate-api.com/v6/"
    private let key = "f79508cd64660f3119dec344"
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Model PROPERTIES
    @Published var rates: [String : Double] = [:]
    
    func request(currency: CurrencyType) {
        let urlString = baseUrl + key + "/latest/\(currency.rawValue)"
        guard let url = URL(string: urlString) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300  else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .decode(type: ExchangeRates.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: print("parsing seccess")
                case .failure(let error): print("parsing failure, \(error)")
                }
            } receiveValue: { [weak self] model in
                guard let self else { return }
                let compareSet = Set(CurrencyType.allCases.map { $0.rawValue })
                self.rates = model.rates.filter { compareSet.contains($0.key) }
                self.cancellable?.cancel()
            }
    }
}
