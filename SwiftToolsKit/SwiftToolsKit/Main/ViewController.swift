//
//  ViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/6/4.
//  Copyright © 2018年 SwiftToolsKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var datas: [DataModel] = []

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datas = [
            DataModel(title: "DateTools", info: "DateTools"),
            DataModel(title: "ColorTools", info: "ColorTools")
        ]

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
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


    }


}

