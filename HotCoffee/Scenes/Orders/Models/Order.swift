//
//  Order.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/24/21.
//

import Foundation

enum CoffeeType: String, Codable {
    case capuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable {
    case large
    case medium
    case small
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
}
