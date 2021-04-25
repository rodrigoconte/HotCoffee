//
//  AddOrderViewModel.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/25/21.
//

import Foundation

struct addOrderViewModel {
    
    var name: String?
    var email: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}
