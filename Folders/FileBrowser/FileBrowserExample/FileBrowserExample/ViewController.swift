//
//  ViewController.swift
//  FileBrowserExample
//
//  Created by HuyPQ22 on 2021/09/24.
//

import UIKit
import FileBrowser

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func showFileBrowserDidTap(_ sender: Any) {
        let fileBrowser = FileBrowser()
        fileBrowser.modalPresentationStyle = .formSheet
        present(fileBrowser, animated: true, completion: nil)
    }
}

