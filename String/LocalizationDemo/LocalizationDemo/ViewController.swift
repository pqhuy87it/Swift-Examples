//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Shweta Shah on 18/11/19.
//  Copyright © 2019 Agrahyah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var headTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.headTitle.text = NSLocalizedString("title_Label", comment: "")
    }

    @IBAction func englishButtonIsPressed(_ sender: Any) {
        Bundle.setLanguage(lang: "en-IN")
        
        let localizedString = "title_Label".localized()
        self.headTitle.text = localizedString
        
        
    }
    @IBAction func hindiBtnIsPressed(_ sender: Any) {
        
        
        Bundle.setLanguage(lang: "hi")
        
        let localizedString = "title_Label".localized()
        self.headTitle.text = localizedString
    }
    
}

extension String {
//func localized(_ lang:String) ->String {
//
//    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//    let bundle = Bundle(path: path!)
//
//    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//}
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
           bundle = Bundle(path: path!)
    }
}
