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
        
        
        exampleAttributedString()
        exampleExtensionArray()
    }
    
    @IBAction func didTapChangeLabelConstraint(sender: AnyObject) {  
        for ll in labels {
            print(ll.getConstraints(attribute: .centerY))
            print(ll.getConstraints(attribute: .height))
        }
    }
    
    @IBAction func didTapChangeConstraint(sender: AnyObject) {
        print("======= exampleGetConstraint =======")
        let topConstraint = label.getConstraint(attribute: .top)
        let beforeConstant = topConstraint?.constant ?? 0
        topConstraint?.constant = beforeConstant == 0 ? 70 : 0
    }
    

    func exampleAttributedString() {
        guard let text = label.text else { return }
         print("======= exampleAttributedString =======")
        let a = [1,2,3,4]
        
        let attributeString: NSAttributedString
        if let img = UIImage(named: "bg_2") {
            attributeString = text.toAttributedString([
                "Lab": [NSForegroundColorAttributeName : UIColor.brown],
                "abe": [NSBackgroundColorAttributeName : UIColor.purple],
                "{@image}": [TWKitUIImageAttributeName: img]
                ])
            
        } else {
            attributeString = text.toAttributedString([
                "Lab": [NSForegroundColorAttributeName : UIColor.brown],
                "abe": [NSBackgroundColorAttributeName : UIColor.purple]
                ])
        }
        label.attributedText = attributeString
    }
    
    func exampleExtensionArray() {
        print("======= exampleExtensionArray =======")
        var testArray = [Int](repeating: 0, count: 5)
        for i in 0..<testArray.count {
            testArray[i] = i
        }
        
        for i in 0...10 {
            print("testArray[\(i)]: \(testArray[safe: i])")
        }
    }
}

