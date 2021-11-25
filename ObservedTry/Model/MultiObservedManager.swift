//
//  MultiObservedViewModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/11/24.
//

import Foundation

class MultiObservedManager {
    
    static let shared: MultiObservedManager = MultiObservedManager()
    
    private let queue: DispatchQueue = DispatchQueue.init(label: "MultiObservedManager")
        
    @ObservableStructure
    private(set) var blogs: [Blog] = []
    
    private init() {
        var cache: [Blog] = []
        for _ in 0...19 {
            cache.append(Blog(count: 0))
        }
        blogs = cache
    }

    
    func add(_ id: String) {
        guard let index = blogs.firstIndex(where: { $0.id == id  }) else { return }
        var blog = blogs[index]
        blog.add { [weak self] int in
            guard let self = self else { return }
            blog.count = int
            self.stroageBlog(id , new: blog)
        }
    }
    
    func subtract(_ id: String) {
        guard let index = blogs.firstIndex(where: { $0.id == id  }) else { return }
        var blog = blogs[index]
        blog.subtract { [weak self] int in
            guard let self = self else { return }
            blog.count = int
            self.stroageBlog(id , new: blog)
        }
    }
    
    func toggle(_ id: String) {
        guard let index = blogs.firstIndex(where: { $0.id == id  }) else { return }
        var blog = blogs[index]
        blog.toggle {[weak self] bool in
            guard let self = self else { return }
            blog.toggle = bool
            self.stroageBlog(id , new: blog)
        }
    }
    
    
    private func stroageBlog(_ id: String, new blog: Blog) {
        guard let index = blogs.firstIndex(where: { $0.id == id  }) else { return }
        queue.async {
            self.blogs[index] = blog
        }
    }
    
    func getBlog(_ id: String)-> Blog? {
        return blogs.first(where: { $0.id == id})
    }
    
    func getBlog(_ index: Int)-> Blog? {
        guard blogs.indices.contains(index) else { return nil }
        return blogs[index]
    }
}



