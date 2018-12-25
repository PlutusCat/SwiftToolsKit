//
//  ViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/6/4.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

let cellReuseIdentifier = "UITableViewCell_Identifier"

class ViewController: UIViewController {

    var datas: [DataModel] = []

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        tableview.keyboardDismissMode = .interactive

        datas = [
            DataModel(title: "DateTools", info: "DateTools"),
            DataModel(title: "ColorTools", info: "ColorTools"),
            DataModel(title: "TextSizeTools", info: "TextSizeTools"),
            DataModel(title: "NavigationLayout", info: "NavigationLayout"),
            DataModel(title: "Web", info: "WebViewKit")
        ]

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        simpDefer()
        changeNumber(localNumber: &number)
        print(number)
        changeString(value: string)
        print(string)

        test()

    }

    @discardableResult
    func test() -> Int {
        return 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func simpDefer() {
        defer {
            print("11111111")
        }
        print("22222222")
    }

    var number = 12
    var string = "string"

    func changeNumber(localNumber: inout Int) {
        localNumber += 3
    }

    func changeString(value: String) {
        string = value + "value"
    }

    func swapTwoValue<T>(_ aaa: inout T, _ bbbb: inout T) {

    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = datas[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vcName = datas[indexPath.row].title
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"]
        let clsName = "\(namespace!)." + vcName + "ViewController"
        let classType = NSClassFromString(clsName) as? UIViewController.Type
        let viewController = classType!.init()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

//protocol Builder {}
////class Builde { }
//
//extension Builder {
//    public func with(configure: (inout Self) -> Void) -> Self {
//        var this = self
//        configure(&this)
//        return this
//    }
//}
//
//extension NSObject: Builder {
//    private let table = UITableView(frame: .zero, style: .plain).with { (view) in
//        view.backgroundColor = .white
//        view.separatorColor = .darkGray
//        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10.0, right: 0)
//        view.allowsMultipleSelection = true
//    }
//}
//
