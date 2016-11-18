//
//  DispatchTime+Extension.swift
//  TWKitDemo
//
//  Created by kimtaewan on 2016. 11. 18..
//  Copyright © 2016년 taewan. All rights reserved.
//

import Foundation

public extension DispatchTime {
    public static func after(_ dealy: Double) -> DispatchTime {
       return DispatchTime.now() + dealy
    }
}
