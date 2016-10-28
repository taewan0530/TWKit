//
//  EasyStyle.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit


open class EasyStyle: NSObject {
    public typealias ConfigurationBlock = (UIView) -> Void
    
    private(set) var combineKeys: [String?]?
    
    private(set) weak var parentStyle: EasyStyle?
    private(set) var configrationBlock: ConfigurationBlock!

    public init(parentStyle parent: EasyStyle? = nil, configration: @escaping ConfigurationBlock) {
        parentStyle = parent
        configrationBlock = configration
    }

    open class func styleWithConfigration(configration: @escaping ConfigurationBlock) -> EasyStyle {
        return EasyStyle(parentStyle: nil, configration: configration)
    }

    open class func styleWithParent(parent: EasyStyle, configration: @escaping ConfigurationBlock) -> EasyStyle {
        return EasyStyle(parentStyle: parent, configration: configration)
    }

}
