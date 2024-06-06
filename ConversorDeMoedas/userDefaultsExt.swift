//
//  userDefaultsExt.swift
//  ConversorDeMoedas
//
//  Created by Victor Vaz de Oliveira on 03/06/24.
//

import Foundation

extension UserDefaults {
    // Save Current Currency
    func setLeftCurrency(leftCurrency: Currency) {
        set(leftCurrency.rawValue, forKey: "Left Currency")
    }
    func setRightCurrency(rightCurrency: Currency) {
        set(rightCurrency.rawValue, forKey: "Right Currency")
    }
    
    // Get Last Currency
    func getLeftCurrency() -> Double {
        return double(forKey: "Left Currency")
    }
    func getRightCurrency() -> Double {
        return double(forKey: "Right Currency")
    }
    
    // Check if has a saved Currency
    func isThereLeftCurrency() -> Bool {
        return bool(forKey: "Left Currency")
    }
    func isThereRightCurrency() -> Bool {
        return bool(forKey: "Right Currency")
    }
}
