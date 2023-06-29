//
//  ViewModel.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import Combine
import Foundation

final class ViewModel: ObservableObject {
    
    // MARK: Published properties
    @Published var currencyRate: Double = .zero
    @Published var showProgress = false
    
    // MARK: Helpers
    private let dataService = DataService()
    private var rates: [String: Double] = [:]
    private var amount: Double = .zero
    private var cancellable = Set<AnyCancellable>()
    private var amountCurrency: CurrencyType = .usd
    private var targetCurrency: CurrencyType? = nil
    
    init() {
        subscribe()
    }
    
    private func subscribe() {
        dataService.$rates
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rates in
                guard let self, let rate = rates[amountCurrency.rawValue] else { return }
                showProgress = false
                self.rates = rates
                if rate != 1 {
                    currencyRate = rate
                }
                showAmount(amount: self.amount)
            }
            .store(in: &cancellable)
    }
    
    func changedAmount(amount: String) {
        let amountWithoutSpace = amount.replacingOccurrences(of: " ", with: "")
        guard let amounDouble = Double(amountWithoutSpace) else { return }
        
        showAmount(amount: amounDouble)
    }
    
    func showAmount(amount: Double) {
        self.amount = amount
        guard let targetCurrency, let rate = rates[targetCurrency.rawValue] else { return }
        currencyRate = rate * amount
    }
    
    func amountCurrencyDidChanged(currency: CurrencyType) {
        showProgress = true
        dataService.request(currency: currency)
        amountCurrency = currency
    }
    
    func targetCurrencyDidChanged(currency: CurrencyType) {
        targetCurrency = currency
        showAmount(amount: amount)
    }
}
