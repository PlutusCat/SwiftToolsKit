//
//  TextSizeTools.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/9/17.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    public static var titleSize00: CGFloat { return 34}
    public static var titleSize01: CGFloat { return 28}

}

extension UIFont {
    public static var fontCN: UIFont {
        return UIFont(name: "PingFang SC", size: CGFloat.titleSize00)!
    }
}
