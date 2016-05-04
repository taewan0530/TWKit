//
//  StyleGenerator.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 26..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation
import UIKit


//example EasyStyle
class StyleGenerator {
    static private var generated = false
    class func generator() {
        if generated { return }
        generated = true
        
        let manger = EasyStyleManager.sharedInstance
        
        manger.registerStyle("sample") { view in
            if let label = view as? UILabel {
                label.backgroundColor = UIColor.blueColor()
            }
        }
        
        manger.registerStyle("test") { view in
            if let label = view as? UILabel {
                label.textColor = UIColor.cyanColor()
            }
        }
    }
}



@IBDesignable
class IBLabel: UILabel {
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        StyleGenerator.generator()
    }
}

@IBDesignable
class IBButton: UIButton {
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        StyleGenerator.generator()
    }
}