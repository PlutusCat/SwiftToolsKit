//
//  ViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/6/4.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

let CellReuseIdentifier = "UITableViewCell_Identifier"

class ViewController: UIViewController {

    var datas: [DataModel] = []

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        datas = [
            DataModel(title: "DateTools", info: "DateTools"),
            DataModel(title: "ColorTools", info: "ColorTools"),
            DataModel(title: "TextSizeTools", info: "TextSizeTools"),
            DataModel(title: "NavigationLayout", info: "NavigationLayout"),
            DataModel(title: "BaseWeb", info: "BaseWeb")
        ]

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath)
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
        let clss = NSClassFromString(clsName) as! UIViewController.Type
        let VC = clss.init()
        navigationController?.pushViewController(VC, animated: true)

    }


}

