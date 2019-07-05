//
//  Database.swift
//  Katalog
//
//  Created by Mario Rotz on 25.06.19.
//  Copyright © 2019 Mario Rotz. All rights reserved.
//

import SQLite3
import UIKit
class Database {
    var db: OpaquePointer?
    
    func initDatabase()
    {
        let databasePath = Bundle.main.path(forResource: "catalog", ofType: "sqlite")!
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func readCategories()->[Category]
    {
        var categories = [Category]()
        let queryString = "SELECT * FROM categories"
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return []
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let categoryId = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let picture = String(cString: sqlite3_column_text(stmt, 2))
            let category = Category.init()
            category.id = Int(categoryId)
            category.name = String(describing: name)
            category.picture = String(describing: picture)
            categories.append(category)
        }
        return categories
    }
    
    func getProduct(fromCategoryId:Int)->[Product] {
        var products = [Product]()
        let queryString = "SELECT * FROM products WHERE category=\(fromCategoryId)"
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return []
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let productId = sqlite3_column_int(stmt, 0)
            let sku = String(cString: sqlite3_column_text(stmt, 1))
            let name = String(cString: sqlite3_column_text(stmt, 4))
            let descr = String(cString:sqlite3_column_text(stmt, 5))
            let country = String(cString:sqlite3_column_text(stmt, 3))
            let product = Product.init()
            product.productId = Int(productId)
            product.country = country
            product.name = name
            product.sku = sku
            product.descriptionOfProduct = descr
            product.price = sqlite3_column_double(stmt, 11)
            products.append(product)
        }
        return products
    }
}
