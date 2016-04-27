//
//  StyleGenerator.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 26..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation
import UIKit

class StyleGenerator {
    static private var generated = false
    class func generator() {
        if generated { return }
        generated = true
        
        let manger = EasyStyleManager.sharedInstance
        manger.registerStyle("sample", style: EasyStyle.init() { (view) in
            if let label = view as? UILabel {
                label.backgroundColor = UIColor.redColor()
            }
            })
        
        manger.registerStyle("test", style: EasyStyle.init() { (view) in
            if let label = view as? UILabel {
                label.textColor = UIColor.whiteColor()
            }
            })
    }
}


protocol DesignableProtocol {}

extension DesignableProtocol where Self: UIView {
    func prepareForInterfaceBuilder() {
        StyleGenerator.generator()
    }
}

@IBDesignable
class IBLabel: UILabel, DesignableProtocol {}

@IBDesignable
class IBButton: UIButton, DesignableProtocol {}