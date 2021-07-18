//
//  TableViewModelDelegate.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation

protocol TableViewModelDelegate: AnyObject {
    func reload(indexPaths: [IndexPath]?, isReloadAll: Bool)
}
