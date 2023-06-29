//
//  SelectionView.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

extension AmountField {
    enum Action {
        case amountDidChange(String?)
        case currencyDidChange(CurrencyType)
    }
    
    fileprivate enum Constants: CGFloat {
        case tfHeight = 44.0
        case titleFontSize = 14.0
        case space = 8.0
        case borderWidth = 1.5
        case titleHeight = 15.0
        case currencyViewHeight = 35.0
        case currencyViewWidth = 78 
        case flagSize = 25
        case currencyFlagSpacing = 3
    }
}

final class AmountField: UIView {
    
    // MARK: UI Elements
    private let fieldView = UIView().then {
        $0.layer.cornerRadius = Constants.space.rawValue
        $0.layer.borderWidth = Constants.borderWidth.rawValue
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: Constants.titleFontSize.rawValue, weight: .semibold)
    }
    private let textField = UITextField().then {
        let frame = CGRect(x: .zero, y: .zero, width: Constants.space.rawValue, height: .zero)
        $0.leftView = UIView(frame: frame)
        $0.leftViewMode = .always
        $0.placeholder = "Enter Amount"
        $0.addTarget(nil, action: #selector(editingChanged), for: .editingChanged)
        $0.keyboardType = .numberPad
    }
    private let selectionButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        $0.tintColor = .gray
        $0.isUserInteractionEnabled = true
    }
    private let pickerView = UIPickerView()
    private let currencyView = StackView(
        spacing: Constants.currencyFlagSpacing.rawValue,
        alignment: .center,
        axis: .horizontal
    )
    private let currencyFlag = UIImageView()
    private let currencyLabel = UILabel()
    
    //MARK: Helpers
    private let actionHandler: ((Action) -> Void)?
    
    init(actionHandler: (@escaping (Action) -> Void)) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        guard let amount = textField.text?.numberWithSpace() else { return }
        textField.text = amount
        actionHandler?(.amountDidChange(amount))
    }
    
    func setKeyboardType() {
        textField.inputView = nil
    }
}

// MARK: UI
extension AmountField {
    private func setupSubviews() {
        
        titleLabel.then {
            addSubview($0)
             
            $0.text = "Amount"
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leading(leadingAnchor, .zero)
            $0.top(topAnchor)
            $0.height(Constants.titleHeight.rawValue)
        }
        
        fieldView.then {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isUserInteractionEnabled = true
            $0.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.space.rawValue
            ).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.height(Constants.tfHeight.rawValue)
        }
        
        selectionButton.then {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.trailing(trailingAnchor, -Constants.titleFontSize.rawValue)
            $0.height(Constants.tfHeight.rawValue)
            $0.addTapHandler { [weak self] in
                guard let self else { return }
                textField.resignFirstResponder()
                pickerView.delegate = self
                textField.inputView = pickerView
                textField.becomeFirstResponder()
            }
        }
        
        textField.then {
            fieldView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.leading(leadingAnchor)
            $0.trailing(trailingAnchor)
            $0.bottom(bottomAnchor, -Constants.titleHeight.rawValue)
        }
        
        currencyView.then {
            fieldView.addSubview($0)
                        
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.trailing(selectionButton.leadingAnchor)
            $0.height(Constants.currencyViewHeight.rawValue)
            $0.width(Constants.currencyViewWidth.rawValue)
        }
        
        currencyFlag.then {
            currencyView.addArrangedSubview($0)
            $0.width(Constants.currencyViewHeight.rawValue)
            $0.height(Constants.flagSize.rawValue)
        }
        
        currencyLabel.then {
            currencyView.addArrangedSubview($0)
            $0.Y(currencyView.centerYAnchor)
        }
    }
}

extension AmountField: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyType.allCases.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CurrencyType.allCases[row].rawValue
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = CurrencyType.allCases[row].rawValue
        endEditing(true)
        actionHandler?(.currencyDidChange(CurrencyType.allCases[row]))
        setKeyboardType()
        currencyFlag.image = UIImage(named: CurrencyType.allCases[row].rawValue)
    }
}
