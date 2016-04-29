//
// Created by kimtaewan on 2016. 4. 29..
// Copyright (c) 2016 taewan. All rights reserved.
//

import Foundation

public func dispatch_dealy_t(dealy: Double) -> dispatch_time_t {
    return dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * dealy))
}