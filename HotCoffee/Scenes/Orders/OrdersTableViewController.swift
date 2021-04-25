//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/24/21.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL was incorrect")
        }
        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        WebService().load(resource: resource) { result in
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
