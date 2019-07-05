//
//  CategoriesViewController.swift
//  Katalog
//
//  Created by Mario Rotz on 25.06.19.
//  Copyright © 2019 Mario Rotz. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView : UITableView!
    let database = Database()
    var categories : [Category]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database.initDatabase()
        self.categories = self.database.readCategories()
        self.title = "Kategorien"
    }

    //MARK - Tableview delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = self.categories {
            return c.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let c = self.categories {
            cell.textLabel?.text = c[indexPath.row].name
            cell.imageView?.image = UIImage.init(named: c[indexPath.row].picture)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let c = self.categories {
            let category = c[indexPath.row]
            let productsViewController = self.storyboard?.instantiateViewController(withIdentifier: "Products") as! ProductsTableViewController
            productsViewController.products = self.database.getProduct(fromCategoryId: category.id)
            productsViewController.category = category
            self.navigationController?.pushViewController(productsViewController, animated: true)
        }
    }
}

