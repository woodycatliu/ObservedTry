//
//  ViewModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation

class BoardViewModel {
    
    @Observed(queue: .main)
    var blog: Blog = .init(count: 0)
    
    func add() {
        blog.add { [weak self] int in
            guard let self = self else { return }
            self.blog.count = int
        }
    }
    
    func subtract() {
        blog.subtract { [weak self] int in
            guard let self = self else { return }
            self.blog.count = int
        }
    }
    
    func toggle() {
        blog.toggle {[weak self] bool in
            guard let self = self else { return }
            self.blog.toggle = bool
        }
    }
    
}



