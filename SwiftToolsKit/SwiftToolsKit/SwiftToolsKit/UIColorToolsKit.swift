//
//  UIColorToolsKit.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/6/8.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

extension UIColor {

    //MARK:- 主色调 - 背景色
    open class var background: UIColor { return UIColor(hex: "#eeeeee") }

    //Mark:- 灰度
    open class var gray00: UIColor { return UIColor(hex: "#04040F").withAlphaComponent(0.45) }
    open class var gray01: UIColor { return UIColor(hex: "#000019").withAlphaComponent(0.22) }
    open class var gray02: UIColor { return UIColor(hex: "#191964").withAlphaComponent(0.18) }
    open class var gray03: UIColor { return UIColor(hex: "#191964").withAlphaComponent(0.07) }
    open class var gray04: UIColor { return UIColor(hex: "#0A0A78").withAlphaComponent(0.05) }

    //Mark:- 蓝色
    open class var blue00: UIColor { return UIColor(hex: "#5AC8FA") }
    open class var blue01: UIColor { return UIColor(hex: "#007AFF") }
    open class var blue02: UIColor { return UIColor(hex: "#5856D6") }

    //Mark:- 红色
    open class var red00: UIColor { return UIColor(hex: "#FF3B30") }
    open class var red01: UIColor { return UIColor(hex: "#FF2D55") }

    //Mark:- 黄色
    open class var yellow00: UIColor { return UIColor(hex: "#FF9500") }
    open class var yellow01: UIColor { return UIColor(hex: "#ffcc00") }

    //Mark:- 绿色
    open class var green00: UIColor { return UIColor(hex: "#4CD964") }


    /// ......

    /// 十六进制字符串 转 Color
    ///
    /// - Parameter hex: 十六进制字符串
    public convenience init(hex: String) {

        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex

        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}

