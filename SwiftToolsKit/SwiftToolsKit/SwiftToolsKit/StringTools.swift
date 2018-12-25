//
//  StringTools.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/9/4.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func inValue() -> Int {

        var cgInt: Int = 0

        if let doubleValue = Double(self) {
            cgInt = Int(doubleValue)
        }
        return cgInt
    }

    func floatValue() -> CGFloat {
        var cgFloat: CGFloat = 0

        if let doubleValue = Double(self) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}
