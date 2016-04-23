//
//  EasyFitImageView.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

public class EasyFitImageView: UIImageView {
    private var _fitMultipler: CGFloat = 0
    
    @IBInspectable var fitPriority: Float = 999 {
        didSet { setNeedsLayout() }
    }
    
    public var fitMultipler: CGFloat {
        get { return _fitMultipler }
        set {
            _fitMultipler = max(0, min(1000, newValue))
            setNeedsLayout()
        }
    }
    
    override public var image: UIImage? {
        didSet {
            if let image = self.image {
                _fitMultipler = image.size.width/image.size.height
            } else {
                _fitMultipler = 0
            }
        }
    }
    
    override public func layoutSubviews() {
        updateContentSize()
        super.layoutSubviews()
    }
}


//MARK: - private func
private extension EasyFitImageView {
    func updateContentSize() {
        for constraint in self.constraints {
            if constraint.firstItem === constraint.secondItem &&
                (constraint.firstAttribute == .Width || constraint.secondAttribute == .Width) &&
                (constraint.firstAttribute == .Height || constraint.secondAttribute == .Height) &&
                (constraint.multiplier != fitMultipler) //이전이랑 같으면
            {
                self.removeConstraint(constraint)
                break
            }
        }
        
        if 0 < fitPriority && 0 < fitMultipler {
            let constraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: fitMultipler, constant: 0)
            constraint.priority = min(UILayoutPriorityRequired, fitPriority)
            self.addConstraint(constraint)
        }
    }
    
}
