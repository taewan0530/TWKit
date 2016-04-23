//
//  UIView+EasyStyle.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//


import UIKit

public extension UIView {
    @IBInspectable
    var easyStyle: String {
        get { return "Support only setter" }
        set {
            guard let easyStyle = EasyStyleManager.sharedInstance[newValue] else { return }
            applyStyle(easyStyle)
        }
    }
}


private extension UIView {
    func applyStyle(style: EasyStyle) {
        if let parent = style.parentStyle {
            self.applyStyle(parent)
        }
        style.configrationBlock(self)
    }
}