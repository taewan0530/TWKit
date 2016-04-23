//
//  EasyStyle.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public typealias EasyStyleConfigurationBlock = UIView -> Void

public class EasyStyle: NSObject {
 
    private(set) var parentStyle: EasyStyle?
    private(set) var configrationBlock: EasyStyleConfigurationBlock!
    
    init(parentStyle parent: EasyStyle? = nil, configration: EasyStyleConfigurationBlock) {
        parentStyle = parent
        configrationBlock = configration
    }
    
    
    public class func styleWithConfigration(configration: EasyStyleConfigurationBlock) -> EasyStyle {
        return EasyStyle(parentStyle: nil, configration: configration)
    }
    
    public class func styleWithParent(parent: EasyStyle, configration: EasyStyleConfigurationBlock) -> EasyStyle {
        return EasyStyle(parentStyle: parent, configration: configration)
    }
}