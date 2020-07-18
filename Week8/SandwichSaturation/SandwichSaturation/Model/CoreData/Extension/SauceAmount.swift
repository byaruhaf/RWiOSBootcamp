//
//  SauceAmount.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 16/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

extension SauceAmountModel{
    var sauceAmount: SauceAmount {
        get {
            guard let sauceAmountString = self.sauceAmountString,
            let amount = SauceAmount(rawValue: sauceAmountString)
            else { return .none }
            return amount
        }

        set {
            self.sauceAmountString = newValue.rawValue
        }
    }
}
