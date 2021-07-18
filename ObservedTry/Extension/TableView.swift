//
//  TableView.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.description())
    }
    
}
