//
//  EasyStyleManager.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation


public class EasyStyleManager {
    class var sharedInstance: EasyStyleManager {
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
    
    subscript(key: String) -> EasyStyle? {
        let trimKey = key.trim()
        let contains = registeredStyles.contains { $0.0 == trimKey }
        if contains {
            return registeredStyles[trimKey]
        }
        return nil
    }
    
    func registerStyle(key: String, style: EasyStyle) {
        let trimKey = key.trim()
        registeredStyles[trimKey] = style
    }
    
    func unregisterStyleWithKey(key: String) {
        let trimKey = key.trim()
        registeredStyles.removeValueForKey(trimKey)
    }
}