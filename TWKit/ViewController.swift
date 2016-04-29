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

        let stobjc = StructObject(CGRectMake(0,0,10,10))
        let a = stobjc as AnyObject
        
        let url = StructObject<NSURL>.from(a)
        print(url)
        let rect = StructObject<CGRect>.from(a)
        print(rect)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }

}

