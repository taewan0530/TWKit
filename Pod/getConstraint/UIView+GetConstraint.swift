//
//  UIView+GetConstraint.swift
//  EasyKit
//
//  IBOulet로 Constraint를 참조 시키는게 개취가 아니라 만든 extension
//  
//
//  Created by kimtaewan on 2016. 4. 27..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public extension UIView {
    public func getConstraint(identifier: String) -> NSLayoutConstraint? {
        if let superview = self.superview {
            for constraint in superview.constraints where constraint.identifier == identifier {
                return constraint
            }
        }
        for constraint in self.constraints where constraint.identifier == identifier {
            return constraint
        }
        return nil
    }

    public func getConstraint(attribute attr: NSLayoutAttribute) -> NSLayoutConstraint? {
        let constrinsts = getConstraints(attribute: attr)
        if constrinsts.count == 1 {
            return constrinsts.first
        }
        //active deactive도 확인한번 해줄까.
        return constrinsts.maxElement {
             $0.0.priority < $0.1.priority
        }
    }

    public func getConstraints(attribute attr: NSLayoutAttribute) -> [NSLayoutConstraint] {
        return getConstraints(item: self, attribute: attr)
    }

    public func getConstraints(item view: AnyObject, attribute attr: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var results: [NSLayoutConstraint] = []

        if let superview = self.superview {
            results += UIView.targetFromConstraints(superview, item: view, attribute: attr)
        }
        results += UIView.targetFromConstraints(self, item: view, attribute: attr)
        
        return results
    }
    
    
    private class func targetFromConstraints(target: AnyObject, item view: AnyObject, attribute attr: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var results: [NSLayoutConstraint] = []
        
        for constraint in target.constraints {
            if "NSContentSizeLayoutConstraint" == classNameAsString(constraint) {
                continue
            }
            
            let targetAttribute: NSLayoutAttribute
            let targetView: AnyObject?
            
            if "_UILayoutGuide" == classNameAsString(constraint.firstItem) {
                targetAttribute = constraint.secondAttribute
                targetView = constraint.secondItem
            } else {
                targetAttribute = constraint.firstAttribute
                targetView = constraint.firstItem
            }
            
            guard targetAttribute == attr && targetView === view else {
                continue
            }
            results.append(constraint)
        }
        return results
    }


    private class func classNameAsString(obj: Any) -> String {
        return String(obj.dynamicType).componentsSeparatedByString("__").last!
    }
}
