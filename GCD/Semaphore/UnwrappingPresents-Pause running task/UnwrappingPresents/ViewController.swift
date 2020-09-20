//
//  ViewController.swift
//  UnwrappingPresents
//
//  Created by Valentin Kalchev on 03/08/2015.
//  Copyright © 2015 TriggertrapLtd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var unwrapButton: BorderButton!
    @IBOutlet weak var pauseButton: BorderButton!
    @IBOutlet weak var resumeButton: BorderButton!
    @IBOutlet weak var suspendButton: BorderButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
    }
    
    // MARK: - Actions
    
    @IBAction func unwrapButtonTapped(button: BorderButton) {
        setEnabled(false, forButton: unwrapButton)
        setEnabled(true, forButton: pauseButton)
        setEnabled(false, forButton: resumeButton)
        setEnabled(true, forButton: suspendButton)

        let presents = Presents(unwrappables: [Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present(), Present()])
        
        Manager.sharedInstance.unwrappableDelegate = self
        Manager.sharedInstance.startUnwrapping(presents)
    }
    
    @IBAction func pauseButtonTapped(button: BorderButton) {
        
        setEnabled(false, forButton: unwrapButton)
        setEnabled(false, forButton: pauseButton)
        setEnabled(true, forButton: resumeButton)
        setEnabled(true, forButton: suspendButton)
        
        Manager.sharedInstance.pauseUnwrapping()
    }
    
    @IBAction func resumeButtonTapped(button: BorderButton) {
        
        setEnabled(false, forButton: unwrapButton)
        setEnabled(true, forButton: pauseButton)
        setEnabled(false, forButton: resumeButton)
        setEnabled(true, forButton: suspendButton)
        
        Manager.sharedInstance.resumeUnwrapping()
    }
    
    @IBAction func suspendButtonTapped(button: BorderButton) {
        
        setEnabled(true, forButton: unwrapButton)
        setEnabled(false, forButton: pauseButton)
        setEnabled(false, forButton: resumeButton)
        setEnabled(false, forButton: suspendButton)
        
        Manager.sharedInstance.suspendUnwrapping()
    }
    
    // MARK: - Private
    
    private func setEnabled(_ enabled: Bool, forButton button: BorderButton) {
        button.isEnabled = enabled
        button.borderColor = enabled ? UIColor.green : UIColor.red
    }
}

extension ViewController: ManagerLifecycle {
    func didFinishUnwrapping() {
        
        setEnabled(true, forButton: unwrapButton)
        setEnabled(false, forButton: pauseButton)
        setEnabled(false, forButton: resumeButton)
        setEnabled(false, forButton: suspendButton)
    }
}

