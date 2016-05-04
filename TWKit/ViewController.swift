//
//  ViewController.swift
//  EasyKit
//
//  Created by kimtaewan on 2016. 4. 22..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: IBLabel!
    @IBOutlet weak var buttonButton: UIButton!
    
    @IBOutlet weak var labelButton: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        exampleStructObject()
        exampleAttributedString()
        exampleExtensionArray()
    }
    
    @IBAction func didTapChangeLabelConstraint(sender: AnyObject) {  
        for ll in labels {
            print(ll.getConstraints(attribute: .CenterY))
            print(ll.getConstraints(attribute: .Height))
        }
    }
    
    @IBAction func didTapChangeConstraint(sender: AnyObject) {
        print("======= exampleGetConstraint =======")
        let topConstraint = label.getConstraint(attribute: .Top)
        let beforeConstant = topConstraint?.constant ?? 0
        topConstraint?.constant = beforeConstant == 0 ? 70 : 0
        
      
        
        
        print(buttonButton.getConstraints(item: buttonButton, attribute: .Bottom))
        print(buttonButton.getConstraint(attribute: .Bottom))
    }
    
    func exampleStructObject() {
        print("======= exampleStructObject =======")
        let stobjc = StructObject(CGRectMake(0,0,10,10))
        let a = stobjc as AnyObject
        
        let url = StructObject<NSURL>.from(a)
        print("StructObject as NSURL is: \(url)")
        let rect = StructObject<CGRect>.from(a)
        print("StructObject as CGRect is: \(rect)")
    }
    
    func exampleAttributedString() {
        guard let text = label.text else { return }
         print("======= exampleAttributedString =======")
        
        let attributeString: NSAttributedString
        if let img = UIImage(named: "bg_2") {
            attributeString = text.toAttributedString([
                "Lab": [NSForegroundColorAttributeName : UIColor.brownColor()],
                "abe": [NSBackgroundColorAttributeName : UIColor.purpleColor()],
                "{@image}": [TWKitUIImageAttributeName: img]
                ])
            
        } else {
            attributeString = text.toAttributedString([
                "Lab": [NSForegroundColorAttributeName : UIColor.brownColor()],
                "abe": [NSBackgroundColorAttributeName : UIColor.purpleColor()]
                ])
        }
        label.attributedText = attributeString
    }
    
    func exampleExtensionArray() {
        print("======= exampleExtensionArray =======")
        var testArray = [Int](count: 5, repeatedValue: 0)
        for i in 0..<testArray.count {
            testArray[i] = i
        }
        
        for i in 0...10 {
            print("testArray[\(i)]: \(testArray[safe: i])")
        }
    }
}

