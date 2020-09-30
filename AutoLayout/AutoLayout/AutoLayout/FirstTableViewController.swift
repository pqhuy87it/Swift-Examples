//
//  firstTableViewController.swift
//  AutoLayout
//
//  Created by JohnLui on 15/3/23.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class firstTableViewController: UITableViewController {
    
    var labelArray = Array<String>() // 用于存储 label 文字内容

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "firstTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "firstTableViewCell")
        
        // 感谢 https://github.com/banxi1988 使用下面两行代码替代 estimatedHeightForRowAtIndexPath 实现了自动计算 UITableViewCell 高度
        // 经过测试，实际表现及运行效率均相似，大👍
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        // 循环生成 label 文字内容
        for i in 1...10 {
            var text = ""
            for _ in 1...i {
                text += "Auto Layout "
            }
            labelArray.append(text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableViewCell", for: indexPath as IndexPath) as! firstTableViewCell

        cell.firstLabel.text = labelArray[indexPath.row]
        
        var image = UIImage(named: (indexPath.row % 3).description)!
        if image.size.width > 80 {
            image = image.resizeToSize(size: CGSize(width: 80, height: image.size.height * (80 / image.size.width)))
        }
        cell.logoImageView.image = image

        return cell
    }
}
