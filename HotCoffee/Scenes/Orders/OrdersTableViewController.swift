//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/24/21.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    // MARK: - Attributes
    
    var ordersListViewModel = OrderListViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.ordersListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - Table view Data source and Delegate

extension OrdersTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.ordersListViewModel.orderViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.detailTextLabel?.text = vm.type
        cell.textLabel?.text = vm.name
        return cell
    }
    
}
