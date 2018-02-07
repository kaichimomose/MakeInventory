//
//  AddInventoryViewController.swift
//  MakeInventory
//
//  Created by Eliel A. Gordon on 11/12/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class AddInventoryViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    var inventory: Inventory?
    
    weak var delegate: UpdateDelegate?
    
    @IBOutlet weak var inventoryNameField: UITextField!
    @IBOutlet weak var inventoryQuantityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inventory = inventory {
            inventoryNameField.text = inventory.name
            inventoryQuantityField.text = String(inventory.quantity)
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let name = inventoryNameField.text, let quantity = Int64(inventoryQuantityField.text!) else {return}
        
        if let inventory = inventory {
            let backgroundEntity = coreDataStack.privateContext.object(with: inventory.objectID) as! Inventory
            backgroundEntity.name = name
            backgroundEntity.quantity = quantity
            backgroundEntity.date = Date()
            
            coreDataStack.saveTo(context: coreDataStack.privateContext)
            delegate?.updateViewContext(item: inventory)
//            self.coreDataStack.viewContext.refresh(inventory, mergeChanges: true)
        } else {
            
            let inv = Inventory(
                context: coreDataStack.privateContext
            )
            
            inv.name = name
            inv.quantity = quantity
            inv.date = Date()
            
            coreDataStack.saveTo(context: coreDataStack.privateContext)
        }

        self.navigationController?.popViewController(animated: true)
    }
    
}
