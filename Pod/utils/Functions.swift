//
// Created by kimtaewan on 2016. 4. 29..
// Copyright (c) 2016 taewan. All rights reserved.
//

import Foundation

public func dispatch_delay_t(delay: Double) -> DispatchTime {
    return DispatchTime.now() + Double(NSEC_PER_SEC) * delay
}
