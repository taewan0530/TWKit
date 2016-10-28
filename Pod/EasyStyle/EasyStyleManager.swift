//
//  EasyStyleManager.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation


open class EasyStyleManager {

    public static let sharedInstance: EasyStyleManager = EasyStyleManager()
    
    private var registeredStyles: [String: EasyStyle] = [:]


    open subscript(key: String?) -> EasyStyle? {
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

    open func registerStyle(key: String, parent: String? = nil, configuration: @escaping EasyStyle.ConfigurationBlock) {
        self[key] = EasyStyle(parentStyle: self[parent], configration: configuration)
    }

    open func registerStyle(key: String, style: EasyStyle) {
        self[key] = style
    }

    open func unregisterStyleWithKey(key: String) {
        registeredStyles.removeValue(forKey: key.trim)
    }
}

private extension String {
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
