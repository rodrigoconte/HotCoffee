//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Rodrigo Oliveira on 4/24/21.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    private(set) var vm = addOrderViewModel()
    private(set) var coffeeSizeSegmentedController: UISegmentedControl!

    @IBOutlet private(set) weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        coffeeSizeSegmentedController = UISegmentedControl(items: self.vm.sizes)
        coffeeSizeSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeeSizeSegmentedController)
        
        coffeeSizeSegmentedController.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizeSegmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = vm.types[indexPath.row]
        return cell
    }
    
}
