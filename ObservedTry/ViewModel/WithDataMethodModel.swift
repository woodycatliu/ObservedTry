//
//  WithDataMethodViewModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation

class WithDataMethodModel {
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
        
        blogs[index].add { [weak self] int in
            self?.blogs[index].count = int
            self?.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
    func subtract(indexPath: IndexPath) {
        let index = indexPath.row
        guard blogs.indices.contains(index) else { return }
        blogs[index].subtract { [weak self] int in
            guard let self = self else { return }
            self.blogs[index].count = int
            self.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
    func toggle(indexPath: IndexPath) {
        let index = indexPath.row
        guard blogs.indices.contains(index) else { return }
        blogs[index].toggle { [weak self] bool in
            self?.blogs[index].toggle = bool
            self?.delegate?.reload(indexPaths: [indexPath], isReloadAll: false)
        }
    }
    
}
