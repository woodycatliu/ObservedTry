//
//  BoardDataModel.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation

struct Blog: Codable {
    
    let id: String
    
    var count: Int
    
    var toggle: Bool = false
    
    init(count: Int) {
        id = UUID().uuidString
        
        self.count = count
    }
    
    func add(completion: @escaping (Int)-> Void) {
        APIManager.shared.add {
            int in
            let value = count + int
            completion(value)
        }
    }
    
    func subtract(completion: @escaping (Int)-> Void) {
        APIManager.shared.subtract {
            int in
            var value = count + int
            value = value < 0 ? 0 : value
            completion(value)
        }
    }
    
    func toggle(completion: @escaping (Bool)-> Void) {
        APIManager.shared.toggle(toggle) {
            bool in
            completion(bool)
        }
    }
    
}


