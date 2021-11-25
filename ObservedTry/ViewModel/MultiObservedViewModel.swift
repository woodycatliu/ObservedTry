//
//  MultiObservedViewModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/11/24.
//

import Foundation

class MultiObservedViewModel {
    
    private(set) var id: String? {
        didSet {
            if id != nil {
                observed()
            }
            else {
                cancell()
            }
        }
    }
    
    @Observed(queue: .main)
    private(set) var blog: Blog = .init(count: 0)
    
    private var anyCancelable = Set<ObservableCancellable>()
    
    let identifier: String = UUID().uuidString
    
    deinit {
        cancell()
        print("MultiObservedViewModel is deinit, id: \(identifier)")
    }
    
    func add() {
        guard let id = id else { return }
        MultiObservedManager.shared.add(id)
    }

    func subtract() {
        guard let id = id else { return }
        MultiObservedManager.shared.subtract(id)
    }

    func toggle() {
        guard let id = id else { return }
        MultiObservedManager.shared.toggle(id)
    }
    
    func updateID(_ id: String?) {
        self.id = id
    }
}

extension MultiObservedViewModel {
    
    private func observed() {
        MultiObservedManager.shared.$blogs
            .observe(identifier, queue: .global()) { [weak self] bs in
                guard let self = self else { return }
                self.configure()
            }.store(&anyCancelable)
    }
    
    private func configure() {
        guard let id = id,
              let blog = MultiObservedManager.shared.getBlog(id)
        else { return }
        self.blog = blog
    }
    
    private func cancell() {
        MultiObservedManager.shared.$blogs.cancel(identifier)
    }
    
}
