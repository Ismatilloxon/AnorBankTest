//
//  ViewController.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit
import Combine

extension ViewController {
    enum Constants {
        static let alertBGColor: UIColor = .gray.withAlphaComponent(0.6)
        static let alertWidth = UIScreen.main.bounds.width - 100
        static let alertHeight: CGFloat = 200.0
        static let alertCornerRadius = 16.0
        static let borderWidth = 1.5
        static let fontSize: CGFloat = 22
    }
}

final class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellable = Set<AnyCancellable>()
    private var isSuccess: Bool = false
    
    private lazy var mainView = MainView { [weak self] action in
        guard let self else { return }
        
        switch action {
        case .amountFieldDidChanges(let amount):
            guard let amount else { return }
            viewModel.changedAmount(amount: amount)
        case .changeAmountCurrencyDidPressed(let amountCurrency):
            viewModel.amountCurrencyDidChanged(currency: amountCurrency)
        case .targetCurrencyDidChanged(let targetCurrency):
            viewModel.targetCurrencyDidChanged(currency: targetCurrency)
        case .submitButtonPressed:
            showAlert()
        }
    }
    
    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()                
        binding()
        
        view.overrideUserInterfaceStyle = .light
    }
    
    func binding() {
        viewModel.$currencyRate
            .sink { [weak self] in
                self?.mainView.setCurrencyRate(text: $0.description)
            }.store(in: &cancellable)
        
        viewModel.$showProgress
            .sink { [weak self] in
                self?.mainView.setCurrencyRate(text: $0 == true ? "Progress....." : "")
            }.store(in: &cancellable)
    }
    
    private func showAlert() {
        let alertBG = UIView(frame: view.frame)
        let alertView = UIView()
        alertBG.backgroundColor = Constants.alertBGColor
        
        alertBG.addSubview(alertView)
        
        alertView.frame.size.width = Constants.alertWidth
        alertView.frame.size.height = Constants.alertHeight
        alertView.center.x = alertBG.center.x
        alertView.center.y = alertBG.center.y
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = Constants.alertCornerRadius
        alertView.layer.borderColor = UIColor.black.cgColor
        alertView.layer.borderWidth = Constants.borderWidth
        alertBG.addTapHandler {
            alertBG.removeFromSuperview()
        }
        
        isSuccess.toggle()
        let alertTitle = isSuccess ? "Success ✅ " : "Error ❌"
        let alertLabel = UILabel()
        alertLabel.text = alertTitle
        alertView.addSubview(alertLabel)
        
        alertLabel.frame = alertView.bounds
        alertLabel.textAlignment = .center
        alertLabel.font = .italicSystemFont(ofSize: Constants.fontSize)
        
        view.addSubview(alertBG)
    }
}

