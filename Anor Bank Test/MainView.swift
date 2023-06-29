//
//  BaseView.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

enum Action {
    case amountFieldDidChanges(String?)
    case changeAmountCurrencyDidPressed(CurrencyType)
    case targetCurrencyDidChanged(CurrencyType)
    case submitButtonPressed
}

enum Constants: CGFloat {
    case navigationTitleFontSize = 25.0
    case selectionViewHeight = 80.0
    case navTitleTopInset = 35
    case containerSpacing = 50
    case inset = 16
    case shadowOffset = 3
    case borderWidth = 1.5
    case cornerRadius = 4.0
    case topInset = 20
    case submitButtonWidth = 200
}

final class MainView: UIView {
    
    // MARK: UI Elements
    private let navigationTitle = UILabel().then {
        $0.text = "<  Currency converter"
        $0.font = .boldSystemFont(ofSize: Constants.navigationTitleFontSize.rawValue)
    }
    private lazy var amountField = AmountField { [weak self] action in
        switch action {
        case .amountDidChange(let amount):
            guard amount?.isEmpty == false else {
                self?.hideCurrencyRate()
                return
            }
            self?.actionHandler(.amountFieldDidChanges(amount))
        case .currencyDidChange(let currency):
            self?.actionHandler(.changeAmountCurrencyDidPressed(currency))
        }
    }
    private lazy var currencyField = CurrencyField { [weak self] action in
        switch action {
        case .targetCurrencyDidChange(let currency):
            self?.actionHandler(.targetCurrencyDidChanged(currency))
        }
    }
    private let staticContentContainer = StackView(
        spacing: Constants.containerSpacing.rawValue,
        margins: .init(horizontal: Constants.inset.rawValue, vertical: Constants.navTitleTopInset.rawValue)
    )
    private let submitButton = UIButton(type: .system).then {
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .init(
            width: Constants.shadowOffset.rawValue,
            height: Constants.shadowOffset.rawValue
        )
        $0.layer.shadowOpacity = Float(Constants.borderWidth.rawValue)
        $0.layer.shadowRadius = .zero
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = Constants.borderWidth.rawValue
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = Constants.cornerRadius.rawValue
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.setTitle("Submit", for: .normal)
        $0.addTarget(nil, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Helpers
    private let actionHandler: (Action) -> Void

    // MARK: - Lifecycle
    init(actionHandler: @escaping (Action) -> Void) {
        self.actionHandler = actionHandler
        
        super.init(frame: .zero)
        setupSubviews()
        
        addTapHandler { [weak self] in
            self?.endEditing(true)
            self?.amountField.setKeyboardType()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func submitButtonPressed() {
        actionHandler(.submitButtonPressed)
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        
        staticContentContainer.then {
            $0.views(navigationTitle, amountField, currencyField, submitButton)
            $0.embed(into: self, margins: .topLeft(UIApplication.shared.safeAreaInsets.top), style: .topFill)
        }

        submitButton.then {
            addSubview($0)
            
            $0.top(staticContentContainer.bottomAnchor, Constants.topInset.rawValue)
            $0.X(centerXAnchor)
            $0.height(Constants.containerSpacing.rawValue)
            $0.width(Constants.submitButtonWidth.rawValue)
        }
    }
}

// MARK: Public methods
extension MainView {
    func setCurrencyRate(text: String) {
        currencyField.setCurrencyRate(amount: text)
    }
    
    func hideCurrencyRate() {
        currencyField.hideCurrencyRate()
    }
}
