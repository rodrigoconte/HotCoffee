//
//  Order.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/24/21.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case capuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
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

extension Order {
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("error while creating URL") }
        return Resource<[Order]>(url: url)
    }()
    
    init?(_ vm: addOrderViewModel) {
        guard let name = vm.name,
              let email = vm.email,
              let type = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let size = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else { return nil }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
    }
    
}

extension Order {
    
    static func create(vm: addOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("error while creating URL") }
        
        do {
            let data = try JSONEncoder().encode(order)
            var resource = Resource<Order?>(url: url)
            resource.httpMethod = .post
            resource.body = data
            return resource
        } catch {
            fatalError("Error enconding order")
        }
    }
    
}
