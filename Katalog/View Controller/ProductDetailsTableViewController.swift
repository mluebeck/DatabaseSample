//
//  ProductDetailsTableViewController.swift
//  Katalog
//
//  Created by Mario Rotz on 25.06.19.
//  Copyright © 2019 Mario Rotz. All rights reserved.
//

import UIKit

class ProductDetailsTableViewController: UITableViewController {
    var product : Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.product?.name
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailCell", for: indexPath)
        if let p = self.product {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Preis: \(p.price)"
            case 1:
                cell.textLabel?.text = "Id: \(p.productId)"
            case 2:
                cell.textLabel?.text = "Beschreibung: \(p.descriptionOfProduct)"
            case 3:
                cell.textLabel?.text = "SKU: \(p.sku)"
            case 4:
                cell.textLabel?.text = "Land: \(p.country)"
            case 5:
                cell.textLabel?.text = "Name: \(p.name)"
            default:
                cell.textLabel?.text = ""
            }
        }
        return cell
    }
}
