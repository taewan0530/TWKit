//
//  ScrollViewController.swift
//  TWKitDemo
//
//  Created by kimtaewan on 2016. 11. 18..
//  Copyright © 2016년 taewan. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    private var keyboardHelper: KeyboardHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHelper = KeyboardHelper(scrollView: scrollView)
    }
    deinit {
        print("deinit ScrollViewController")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
