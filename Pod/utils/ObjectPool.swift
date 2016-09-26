//
//  ObjectPool.swift
//  TWKit
//
//  객체 재사용시 사용하면 유용함.
//  Created by kimtaewan on 2016. 4. 28..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public class ObjectPool<T>: NSObject {
    public typealias GeneratorBlock = () -> T
    
    public private(set) var activeList = [T]()
    public private(set) var deactiveList = [T]()
    
    fileprivate var generatorBlock: GeneratorBlock?
    
    public init(generatorBlock block: GeneratorBlock? = nil) {
        generatorBlock = block
        super.init()
    }
    
    public func getInstance() -> T! {
        var instance: Any?
        if deactiveList.count == 0 {
            instance = createInstance()
        } else {
            instance = deactiveList.removeFirst()
        }
        guard let genericObj = instance as? T else {
            assertionFailure(); return nil
        }
        activeList.append(genericObj)
        return genericObj
    }
    
    public func returnInstance(instance: T) {
        for (idx, value) in activeList.enumerated() {
            if isEqual(a: instance, b: value) {
                //view객체라면 화면에서 제거.
                if let view = instance as? UIView {
                    view.removeFromSuperview()
                }
                deactiveList.append(instance)
                activeList.remove(at: idx)
                return
            }
        }
    }
}


extension ObjectPool {
    internal func createInstance() -> Any! {
        if let generator = generatorBlock {
            return generator()
        }
        guard let clz = T.self as? NSObject.Type else {
            assertionFailure("generic class support only 'NSObject' type. or plz use generatorBlock.")
            return nil
        }
        return clz.init()
    }
    
    internal func isEqual(a: T, b: T) -> Bool {
        let aObj = a as AnyObject
        let bObj = b as AnyObject
        return aObj === bObj
    }
}
