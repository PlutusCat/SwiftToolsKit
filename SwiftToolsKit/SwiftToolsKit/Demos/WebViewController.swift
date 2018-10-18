//
//  WebViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/10/17.
//  Copyright © 2018 SwiftToolsKit. All rights reserved.
//

import UIKit

class WebViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://www.apple.com"
        load(URLRequest(url: URL(string: url)!))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
