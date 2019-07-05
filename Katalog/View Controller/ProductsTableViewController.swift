//
//  ProductsTableViewController.swift
//  Katalog
//
//  Created by Mario Rotz on 25.06.19.
//  Copyright © 2019 Mario Rotz. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    var products : [Product]?
    var category: Category?
    
    //MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.category?.name
    }
    
    
    // MARK: - Table view  delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let p = self.products {
            return p.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        if let productArray = self.products
        {
            cell.textLabel?.text = productArray[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        if let p = self.products {
            let product = p[i]
            let productsDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetail") as! ProductDetailsTableViewController
            productsDetailViewController.product = product
            self.navigationController?.pushViewController(productsDetailViewController, animated: true)
        }
    }
}
