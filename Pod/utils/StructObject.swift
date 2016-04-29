//
//  StructObject.swift
//  TWKitDemo
//
//  performSegueWithIdentifier(identifier:, sender:)에 서 sender가 AnyObject라서 만든 클래스
//  struct를 AnyObject에 넣고 싶을때 사용.
//
//  Created by kimtaewan on 2016. 4. 28..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation


public class StructObject<T> {
    public let value: T

    init(_ value: T) {
        self.value = value
    }

    class func from(anyObject: AnyObject?) -> T? {
        guard let obj = anyObject as? StructObject<T> else {
            return nil
        }
        return obj.value
    }
}
