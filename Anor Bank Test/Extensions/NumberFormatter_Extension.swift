//
//  NumberFormatter_Extension.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit


extension String {
    func numberWithSpace() -> String {
        let replacedAmount = self.replacingOccurrences(of: " ", with: "")
        guard let self = Int(replacedAmount) else { return "" }
        let formater = NumberFormatter()
        formater.groupingSeparator = " "
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self)) ?? "nut number "
    }
    
    func formatted() -> String {
        let replacedAmount = self.replacingOccurrences(of: " ", with: "")
        guard let self = Double(replacedAmount) else { return "" }
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        
        return formater.string(from: NSNumber(value: self)) ?? "nut number "
    }
}
