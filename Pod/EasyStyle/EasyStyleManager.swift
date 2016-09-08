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

    private var registeredStyles: [String: EasyStyle] = [:]


    public subscript(key: String?) -> EasyStyle? {
        get {
            guard let trimedKey = key?.trim else {
                return nil
            }
            return registeredStyles[trimedKey]
        }
        set {
            guard let trimedKey = key?.trim else {
                return
            }
            registeredStyles[trimedKey] = newValue
        }
    }

    public func registerStyle(key: String, parent: String? = nil, configuration: EasyStyle.ConfigurationBlock) {
        self[key] = EasyStyle(parentStyle: self[parent], configration: configuration)
    }

    public func registerStyle(key: String, style: EasyStyle) {
        self[key] = style
    }

    public func unregisterStyleWithKey(key: String) {
        registeredStyles.removeValueForKey(key.trim)
    }
}

private extension String {
    var trim: String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}