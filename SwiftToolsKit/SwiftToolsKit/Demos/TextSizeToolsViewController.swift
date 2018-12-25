//
//  TextSizeToolsViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/9/17.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

class TextSizeToolsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        title = "TextSizeTools"

        let textLabel = LabelKit(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 60))
        textLabel.text = "测试一下测试一下测试一下"
        view.addSubview(textLabel)
    }

}
