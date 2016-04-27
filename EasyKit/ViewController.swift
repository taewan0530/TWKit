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
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "label,Label,label,Label\nlabel,Label,lab-{@image}-el,Label\nlabel,Label,label,Label\nlabel,Label,l-{@image}-abel,Label@@{@icon}@----Label---{@icon}---"
        label.sizeToFit()
        if let text = label.text {
            let img = UIImage(named: "bg_2")!
            let start = currentTimeMillis()
            let attributeString = text.toAttributedString(attributesWithKey:
                [
                    "Lab": [NSForegroundColorAttributeName : UIColor.brownColor()],
                    "abe": [
                        NSForegroundColorAttributeName : UIColor.blueColor(),
                        NSBackgroundColorAttributeName : UIColor.whiteColor()
                    ],
                    "{@image}": [TWKitUIImageAttributeName: img],
//                    "{@icon}": [
//                        TWKitUIImageAttributeName: UIImage(named: "pic_where")!,
//                        TWKitUIImageOffsetYAttributeName: 2
//                    ]
                ])
            
            let end = currentTimeMillis()
            print(end-start)
            label.attributedText = attributeString
        }
        //[NSForegroundColorAttributeName : Constants.mainColor()]
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }

}

