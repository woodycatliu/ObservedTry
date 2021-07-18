//
//  OldModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation


class OldModel {
    
    private(set) var blogs: [Blog] = []
    
    weak var delegate: TableViewModelDelegate?
    
    init() {
        for _ in 1...30 {
            blogs.append(Blog(count: 0))
        }
        delegate?.reload(indexPaths: nil, isReloadAll: true)
    }
    
    func add(indexPath: IndexPath) {
        let index = indexPath.row
        guard blogs.indices.contains(index) else { return }
        
        APIManager.shared.add { [weak self] int in
            self?.blogs[index].count += int
            self?.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
    func subtract(indexPath: IndexPath) {
        let index = indexPath.row
        guard blogs.indices.contains(index) else { return }
        APIManager.shared.subtract { [weak self] int in
            guard let self = self else { return }
            self.blogs[index].count += int
            self.blogs[index].count = self.blogs[index].count < 0 ? 0 : self.blogs[index].count
            self.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
    func toggle(indexPath: IndexPath) {
        let index = indexPath.row
        guard blogs.indices.contains(index) else { return }
        let oldBool = blogs[index].toggle
        APIManager.shared.toggle(oldBool) { [weak self] bool in
            self?.blogs[index].toggle = bool
            self?.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
}
