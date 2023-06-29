//
//  CurrencyField.swift
//  Anor Bank Test
//
//  Created by Ismatilla.adm on 27/06/23.
//

import UIKit

extension CurrencyField {
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
        case fieldViewHeight = 45
    }
}


final class CurrencyField: UIView {
    
    // MARK: UI
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: Constants.titleFontSize.rawValue, weight: .semibold)
    }
    private let fieldView = UIView().then {
        $0.layer.cornerRadius = Constants.space.rawValue
        $0.layer.borderWidth = Constants.borderWidth.rawValue
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let amountLabel = UILabel().then {
        $0.textColor = .green
    }
    private let selectionButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        $0.tintColor = .gray
        $0.isUserInteractionEnabled = true
    }
    private let textField = UITextField().then {
        let frame = CGRect(x: .zero, y: .zero, width: Constants.space.rawValue, height: .zero)
        $0.leftView = UIView(frame: frame)
        $0.leftViewMode = .always
        $0.text = "Select Amount"
        $0.keyboardType = .numberPad
    }
    private let pickerView = UIPickerView()
    private let currencyView = StackView(
        spacing: Constants.currencyFlagSpacing.rawValue,
        alignment: .center,
        axis: .horizontal
    )
    private let currencyFlag = UIImageView()
    private let currencyLabel = UILabel()
    
    private let actionHandler: ((Action) -> Void)?
    
    init(actionHandler: ((Action) -> Void)?) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAlert() {
       
    }
}

extension CurrencyField {
    func setupSubviews() {
        
        titleLabel.then {
            addSubview($0)
             
            $0.text = "Target currency"
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leading(leadingAnchor, .zero)
            $0.top(topAnchor)
            $0.height(Constants.titleHeight.rawValue)
        }
        
        fieldView.then {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.top(titleLabel.bottomAnchor, Constants.space.rawValue)
            $0.leading(leadingAnchor)
            $0.trailing(trailingAnchor)
            $0.height(Constants.fieldViewHeight.rawValue)
        }
        
        textField.then {
            fieldView.addSubview($0)
            $0.inputView = pickerView
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.leading(leadingAnchor)
            $0.trailing(trailingAnchor)
            $0.bottom(bottomAnchor, -Constants.titleHeight.rawValue)
        }
        
        amountLabel.then {
            addSubview($0)
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leading(leadingAnchor)
            $0.top(textField.bottomAnchor, Constants.borderWidth.rawValue)
            $0.height(Constants.titleHeight.rawValue)
        }
        
        selectionButton.then {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.trailing(trailingAnchor, -Constants.titleFontSize.rawValue)
            $0.height(Constants.tfHeight.rawValue)
            $0.addTapHandler { [weak self] in
                guard let self else { return }
                textField.becomeFirstResponder()
            }
        }
        
        pickerView.delegate = self
        
        currencyView.then {
            fieldView.addSubview($0)
                        
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.Y(fieldView.centerYAnchor)
            $0.X(fieldView.centerXAnchor)
            $0.height(Constants.currencyViewHeight.rawValue)
            $0.width(Constants.currencyViewWidth.rawValue)
        }
        
        currencyFlag.then {
            currencyView.addArrangedSubview($0)
            $0.width(35)
            $0.height(25)
        }
        
        currencyLabel.then {
            currencyView.addArrangedSubview($0)
            $0.Y(currencyView.centerYAnchor)
        }

    }
}

extension CurrencyField: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
//        actionHandler?(.currencyDidChange(CurrencyType.allCases[row]))
        textField.text = nil
        currencyFlag.image = UIImage(named: CurrencyType.allCases[row].rawValue)
    }
}

extension CurrencyField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
