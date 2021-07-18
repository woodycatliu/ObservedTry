//
//  APIManager.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import Foundation


/**
 模擬 url request 環境:
 異步 延遲 (delay)秒 後回傳 completion
 
 */
class APIManager {
    
    static let shared: APIManager = APIManager()
    
    let delay: Double = 0.5
    
    private let queue: DispatchQueue = DispatchQueue(label: "APIManager")
    
    private init() {}
    
    func add(completion: @escaping (Int)->()) {
        queue.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.main.async {
                completion(1)
            }
        }
    }
    
    func subtract(completion: @escaping (Int)->()) {
        queue.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.main.async {
                completion(-1)
            }
        }
    }
    
    func toggle(_ bool: Bool, completion: @escaping (Bool)->()) {
        queue.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.main.async {
                completion(!bool)
            }
        }
        
    }
    
}
