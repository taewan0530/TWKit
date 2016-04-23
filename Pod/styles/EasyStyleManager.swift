//
//  EasyStyleManager.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation


public class EasyStyleManager {
    public class var sharedInstance: EasyStyleManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: EasyStyleManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = EasyStyleManager()
        }
        return Static.instance!
    }
    
    private(set) var registeredStyles: [String: EasyStyle] = [:]
    
    public subscript(key: String) -> EasyStyle? {
        let contains = registeredStyles.contains { $0.0 == key }
        if contains {
            return registeredStyles[key]
        }
        return nil
    }
    
    public func registerStyle(key: String, style: EasyStyle) {
        registeredStyles[key] = style
    }
    
    public func unregisterStyleWithKey(key: String) {
        registeredStyles.removeValueForKey("key")
    }
}