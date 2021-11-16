//
//  ObjcObserved.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/24.
//

import Foundation

class ObservedContainer: NSObject {
    var value: Any
    init(_ value: Any) {
        self.value = value
    }
}


@propertyWrapper
public class ObjcObserved: NSObject {
    @objc dynamic private var _value: AnyObject
    
    public var wrappedValue: AnyObject {
        get {
            _value
        }
        set {
            _value = newValue
        }
    }
    
    private var _queue: DispatchQueue? = nil
    
    private var obserationDict: [String: NSKeyValueObservation] = [:]

    public init(wrappedValue: AnyObject, queue: DispatchQueue? = nil) {
        self._value = wrappedValue
        self._queue = queue
    }
    
    
    public func observeNewValue(key: String, closure: @escaping (AnyObject)->()) {
        let obseration = observe(\._value, options: [.new]) { object, change in
            guard let newValue = change.newValue else { return }
            closure(newValue)
        }
        obserationDict[key] = obseration
    }
    
    public func observeOldValue(key: String, closure: @escaping (AnyObject)->()) {
        let obseration = observe(\._value, options: [.old]) { object, change in
            guard let newValue = change.oldValue else { return }
            closure(newValue)
        }
        obserationDict[key] = obseration
    }
    
    public func observeInit(key: String, closure: @escaping (AnyObject)->()) {
        let obseration = observe(\._value, options: [.initial]) { object, change in
            guard let newValue = change.newValue else { return }
            closure(newValue)
        }
        obserationDict[key] = obseration
    }
    
    public func remove(key: String) {
        
//        guard let obseration = obserationDict[key] else { return }
    
        obserationDict[key] = nil
    }
    
    
    
    
    
    
    
    
    
    
}
