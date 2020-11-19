//
//  RootViewController.swift
//  checkExistAndCreateFolder
//
//  Created by Huy Pham on 7/26/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let folderName = "iOS10"
        
        if !checkExistFolder(folderName: folderName) {
            createFolder(folderName: folderName)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkExistFolder(folderName: String) -> Bool {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let folderPath = documentsPath.appending("/\(folderName)")
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        
        if fileManager.fileExists(atPath: folderPath, isDirectory:&isDir) {
            if isDir.boolValue {
                // file exists and is a directory
                print("folder exist")
                return true
            } else {
                // file exists and is not a directory
                print("folder exist and is not a directory")
                return true
            }
        } else {
            // file does not exist
            print("folder does not exist")
            return false
        }
    }
    
    func createFolder(folderName: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let folderPath = documentsPath.appending("/\(folderName)")
        let fileManager = FileManager.default
        
        do {
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            print("created folder \(folderName)")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
