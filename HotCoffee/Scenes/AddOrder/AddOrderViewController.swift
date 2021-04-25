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
            tableView.indicatorStyle = .white
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
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
    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.coffeeSizeSegmentedController.titleForSegment(at: self.coffeeSizeSegmentedController.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedType = vm.types[indexPath.row]
        self.vm.selectedSize = selectedSize
        
        WebService().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
            case .failure(let error):
                print("Error while \(error)")
            case .success(let order):
                print(order)
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
