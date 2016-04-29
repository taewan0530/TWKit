//
//  ObjectPool.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 28..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public class ObjectPool<T>: NSObject {
    public typealias GeneratorBlock = () -> T

    public private(set) var activeList = [T]()
    public private(set) var deactiveList = [T]()

    private var generatorBlock: GeneratorBlock?

    init(generatorBlock block: GeneratorBlock? = nil) {
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
        for (idx, value) in activeList.enumerate() {
            if isEqual(instance, b: value) {
                //view객체라면 화면에서 제거.
                if let view = instance as? UIView {
                    view.removeFromSuperview()
                }
                deactiveList.append(instance)
                activeList.removeAtIndex(idx)
                return
            }
        }
    }
}


private extension ObjectPool {
    private func createInstance() -> Any! {
        if let generator = generatorBlock {
            return generator()
        }
        guard let clz = T.self as? NSObject.Type else {
            assertionFailure("generic class support only 'NSObject' type. or plz use generatorBlock.")
            return nil
        }
        return clz.init()
    }

    private func isEqual(a: T, b: T) -> Bool {
        guard let aObj = a as? AnyObject,
        bObj = b as? AnyObject else {
            return false
        }
        return aObj === bObj
    }
}