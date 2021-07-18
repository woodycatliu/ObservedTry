//
//  OldViewModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation

class OldViewModel {
    
    lazy var model: OldModel = {
        let model = OldModel()
        model.delegate = self
        return model
    }()
    
    var blogs: [Blog] {
        return model.blogs
    }
    
    weak var delegate: TableViewModelDelegate?
    
    func add(indexPath: IndexPath) {
        model.add(indexPath: indexPath)
    }
    
    func subtract(indexPath: IndexPath) {
        model.subtract(indexPath: indexPath)
    }
    
    func toggle(indexPath: IndexPath) {
        model.toggle(indexPath: indexPath)
    }
    
}

// MARK: TableViewModelDelegate
extension OldViewModel: TableViewModelDelegate {
    func reload(indexPaths: [IndexPath]?, isReloadAll: Bool) {
        delegate?.reload(indexPaths: indexPaths, isReloadAll: isReloadAll)
    }
}
