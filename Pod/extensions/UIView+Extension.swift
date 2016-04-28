//
//  UIView+Extension.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 27..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func getConstraint(identifier: String) -> NSLayoutConstraint? {
        if let superview = self.superview  {
            for constraint in superview.constraints where constraint.identifier == identifier {
                return constraint
            }
        }
        for constraint in self.constraints where constraint.identifier == identifier {
            return constraint
        }
        return nil
    }
    
    public func getConstraint(attribute attr1: NSLayoutAttribute) -> NSLayoutConstraint? {
        return getConstraints(attribute: attr1).first
    }
    
    public func getConstraints(attribute attr1: NSLayoutAttribute, toItem view2: AnyObject? = nil, attribute attr2: NSLayoutAttribute? = nil) -> [NSLayoutConstraint] {
        return getConstraints(item: self, attribute: attr1, toItem: view2, attribute: attr2)
    }
    
    public func getConstraints(item view1: AnyObject, attribute attr1: NSLayoutAttribute, toItem view2: AnyObject? = nil, attribute attr2: NSLayoutAttribute? = nil, withSuperview: Bool = true) -> [NSLayoutConstraint] {
        var results: [NSLayoutConstraint] = []
        
        if let superview = self.superview
            where withSuperview {
            results += superview.getConstraints(item: view1, attribute: attr1, toItem: view2, attribute: attr2, withSuperview: false)
        }
        
        for constraint in self.constraints {
            guard constraint.firstItem === view1 && constraint.firstAttribute == attr1 else { continue }
            if view2 == nil && attr2 == nil {
                results.append(constraint)
            } else if constraint.secondItem === view2 && constraint.secondAttribute == attr2 {
                results.append(constraint)
            } else if constraint.secondItem === view2 && attr2 == nil {
                results.append(constraint)
            }
        }
        return results
    }
    
}
