//
//  ViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import CoreData

class InventoriesViewController: UIViewController {
    let stack = CoreDataStack.instance
    
    @IBOutlet weak var tableView: UITableView!
    var inventories = [Inventory]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("")
        
        print("-----Before fetch count: \(self.inventories.count)----")
        
        
        let fetch = NSFetchRequest<Inventory>(entityName: "Inventory")
        do {
            let result = try stack.viewContext.fetch(fetch)
            self.inventories = result
            self.tableView.reloadData()
            print("Did fetch")
            
        }catch let error {
            print(error)
        }
        
        self.stack.viewContext.refreshAllObjects()
        print("-----after fetch count: \(self.inventories.count)----")
        
    }
}


extension InventoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventories.count
    }
}

extension InventoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! inventoriesTableViewCell
        
        let item = inventories[indexPath.row]
        
        cell.titleLabel.text = item.name
        cell.detailLabel.text = "x\(item.quantity)"
        cell.dateLabel.text = item.date?.convertString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let item = inventories[row]
        let addInventoryVC = storyboard?.instantiateViewController(withIdentifier: "AddInventoryViewController") as! AddInventoryViewController
        addInventoryVC.inventory = item
        self.navigationController?.pushViewController(addInventoryVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if editingStyle == .delete {
            stack.delete(with: self.stack, inventoryID: inventories[row].objectID)
            inventories.remove(at: row)
            stack.saveTo(context: stack.privateContext)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: <#T##(UITableViewRowAction, IndexPath) -> Void#>)
//    }
}
