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

    public func getConstraint(attribute attr1: NSLayoutAttribute) -> NSLayoutConstraint? {
        let constrinsts = getConstraints(attribute: attr1)
//        if constrinsts.count == 1 {
//            return constrinsts.first
//        }
        return constrinsts.maxElement { $0.0.priority < $0.1.priority }
    }

    public func getConstraints(attribute attr1: NSLayoutAttribute, toItem view2: AnyObject? = nil, attribute attr2: NSLayoutAttribute? = nil) -> [NSLayoutConstraint] {
        return getConstraints(item: self, attribute: attr1, toItem: view2, attribute: attr2)
    }

    public func getConstraints(item view1: AnyObject, attribute attr1: NSLayoutAttribute, toItem view2: AnyObject? = nil, attribute attr2: NSLayoutAttribute? = nil, withSuperview: Bool = true) -> [NSLayoutConstraint] {
        var results: [NSLayoutConstraint] = []

//        if let superview = self.superview
//        where withSuperview {
//            results += superview.getConstraints(item: view1, attribute: attr1, toItem: view2, attribute: attr2, withSuperview: false)
//        }

        print("view:\(view1),attr1: \(attr1.rawValue)\n\n")
        for constraint in self.constraints {
//            print(constraint.description)
            //부모뷰에서 찾을때는 다르게 순서 바꿔야할듯
            //constraint.firstItem === view1 && 
            guard constraint.firstAttribute == attr1 || constraint.secondAttribute == attr1 else {
                continue
            }
            
            if constraint.constant == 27 || constraint.constant == 10 {
                
                print("constant:\(constraint.constant),\nfirstItem:\(constraint.firstItem):attr\(constraint.firstAttribute.rawValue)\n,secoundItem:\(constraint.secondItem):attr\(constraint.secondAttribute.rawValue)")
            }
            
            
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
