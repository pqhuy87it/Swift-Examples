//
//  MMHomeVC.swift
//  MM
//
//  Created by Boariu Andy on 6/9/15.
//  Copyright (c) 2015 Boariu Andy. All rights reserved.
//

import UIKit
import AVFoundation

class MMHomeVC: UITabBarController, UITabBarControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var btnNewMoment = UIButton()

    // MARK: - ViewController Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //=>    Set delegate
        self.delegate = self
        
        //=>    Keep white color for tab images for both tab states (selected and unselected)
        if let arrItems = tabBar.items {
            for item in arrItems {
                if let image = item.image {
                    item.image = image.imageWithColor(tintColor: UIColor.white).withRenderingMode(.alwaysOriginal)
                }
            }
        }
        
        //=>    Add selected/unselected tab image
        if let arrTabBarItems = tabBar.items {
            let tabBarItem1 = arrTabBarItems[0] 
            let tabBarItem2 = arrTabBarItems[1] 
            
            //=>    Checking device model, and get image corectly for specific device
            var strDeviceModel = "i5"
            if Device.IS_4_INCHES_OR_SMALLER() {
                strDeviceModel = "i5"
            }
            else
                if Device.IS_4_7_INCHES() {
                    strDeviceModel = "i6"
                }
                else
                    if Device.IS_5_5_INCHES() {
                        strDeviceModel = "i6plus"
            }
            
            // Using UIImageRenderingMode.AlwaysOriginal is MANDATORY when we set images for tab bar items!!!!!!
            
            let imgHomeTabNormal  = UIImage(named: "tabHome_normal_\(strDeviceModel)")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            let imgHomeTabSelected  = UIImage(named: "tabHome_selected_\(strDeviceModel)")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            let imgProfileTabNormal  = UIImage(named: "tabProfile_normal_\(strDeviceModel)")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            let imgProfileTabSelected  = UIImage(named: "tabProfile_selected_\(strDeviceModel)")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            let imgTabBarBackground  = UIImage(named: "tabBar_bg_\(strDeviceModel)")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            tabBarItem1.image = imgHomeTabNormal
            tabBarItem1.selectedImage = imgHomeTabSelected
            
            tabBarItem2.image = imgProfileTabNormal
            tabBarItem2.selectedImage = imgProfileTabSelected
            
            //=>    Set appearance to UITabBar
            UITabBar.appearance().tintColor                     = UIColor.white
            UITabBar.appearance().selectionIndicatorImage       = UIImage()
            UITabBar.appearance().shadowImage                   = UIImage()
            UITabBar.appearance().backgroundImage               = imgTabBarBackground
        }

        //=>    Create button programatically, and place it in the middle of tab bar
        addNewMomentButton()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //=>    I incresed the height of tab bar
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 53
        tabFrame.origin.y = self.view.frame.size.height - 53
        self.tabBar.frame = tabFrame
    }
    
    // MARK: - Custom Methods
    
    func addNewMomentButton() {
        btnNewMoment                      = UIButton(type: UIButton.ButtonType.custom)
        btnNewMoment.frame                = CGRect(x: self.view.frame.size.width / 2 - 29, y: self.view.frame.size.height - 67, width: 58, height: 58)
        btnNewMoment.backgroundColor      = UIColor.clear
        btnNewMoment.setImage(UIImage(named: "btnNewMoment"), for: .normal)
        btnNewMoment.setImage(UIImage(named: "btnNewMoment_selected"), for: .highlighted)
        btnNewMoment.addTarget(self, action: #selector(btnNewMoment_Action), for: .touchUpInside)
        self.view.addSubview(btnNewMoment)
    }
    
    // MARK: - Action Methods
    
    @objc func btnNewMoment_Action() {
        
    }
    
    // MARK: - Memory Management Methods

    override func didReceiveMemoryWarning()
    {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
