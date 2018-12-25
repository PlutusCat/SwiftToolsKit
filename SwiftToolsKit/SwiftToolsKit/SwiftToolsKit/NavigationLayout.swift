//
//  NavigationLayout.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/10/12.
//  Copyright © 2018 SwiftToolsKit. All rights reserved.
//

import UIKit

class NavigationLayout {

    /// 获取 StatusBar frame
    public class func getStatusBarFrame() -> CGRect {
        return UIApplication.shared.statusBarFrame
    }

    /// 获取 NavigationBar frame
    public class func getNavigationBar() -> CGRect {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return rootVC?.navigationController?.navigationBar.frame ?? CGRect.zero
    }

    /// 获取安全区
    public class func getSafeArea() -> UIEdgeInsets {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            let safeArea = window?.safeAreaInsets
            return safeArea ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }

    /// 获取安全区 顶部偏移量
    public class func getSafeAreaTop() -> CGFloat {
        guard #available(iOS 11.0, *) else {
            return getStatusBarFrame().height
        }
        let window = UIApplication.shared.keyWindow
        var top = window?.safeAreaInsets.top ?? CGFloat(0)
        top = top > CGFloat(0) ? top : getStatusBarFrame().height
        return top
    }

    /// NavigationBar 固定高度
    /// isFixed = true
    public class func getNavigationBarHeight() -> CGFloat {
        return 44.0
    }

    /// 获取 Navigation 高度
    ///
    /// - Parameter isFixed: 是否是固定高度，false：当 NavigationBar 隐藏时，NavigationBar 高度为0。 true：不管 NavigationBar 是否隐藏，都返回 NavigationBar 高度 44.0 。 默认为 true
    /// - Returns: 返回高度
    public class func getNavigationHeight(isFixed: Bool = true) -> CGFloat {
        guard isFixed else {
            return getSafeAreaTop() + getNavigationBar().height
        }
        return getSafeAreaTop() + getNavigationBarHeight()
    }

}
