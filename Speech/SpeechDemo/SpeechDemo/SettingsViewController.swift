//
//  SettingsViewController.swift
//  SpeechDemo
//
//  Created by Gabriel Theodoropoulos on 2/10/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import AVFoundation


protocol SettingsViewControllerDelegate {
    func didSaveSettings()
}


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tbSettings: UITableView!
    
    
    var delegate: SettingsViewControllerDelegate!
    
	let speechSettings = UserDefaults.standard
    
    var rate: Float!
    
    var pitch: Float!
    
    var volume: Float!
    
	var arrVoiceLanguages: [Dictionary<String, String?>] = []
    
    var selectedVoiceLanguage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Make self the delegate and datasource of the tableview.
        tbSettings.delegate = self
        tbSettings.dataSource = self
        
        // Make the table view with rounded contents.
        tbSettings.layer.cornerRadius = 15.0
        
        
		rate = speechSettings.value(forKey: "rate") as? Float
		pitch = speechSettings.value(forKey: "pitch") as? Float
		volume = speechSettings.value(forKey: "volume") as? Float
    
        
        prepareVoiceList()
        
        //println(AVSpeechSynthesisVoice.speechVoices())
    }

    override func didReceiveMemoryWarning() {
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

    
    // MARK: UITableView method implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row < 3 {
			cell = tableView.dequeueReusableCell(withIdentifier: "idCellSlider", for: indexPath) as UITableViewCell
            
            let keyLabel = cell.contentView.viewWithTag(10) as? UILabel
            let valueLabel = cell.contentView.viewWithTag(20) as? UILabel
			let slider = cell.contentView.viewWithTag(30) as! CustomSlider
            
            var value: Float = 0.0
            switch indexPath.row {
            case 0:
                value = rate
                
                keyLabel?.text = "Rate"
				valueLabel?.text = NSString(format: "%.2f", rate) as String
                slider.minimumValue = AVSpeechUtteranceMinimumSpeechRate
                slider.maximumValue = AVSpeechUtteranceMaximumSpeechRate
				slider.addTarget(self, action: #selector(handleSliderValueChange), for: UIControl.Event.valueChanged)
                slider.sliderIdentifier = 100
                
            case 1:
                value = pitch
                
                keyLabel?.text = "Pitch"
				valueLabel?.text = NSString(format: "%.2f", pitch) as String
                slider.minimumValue = 0.5
                slider.maximumValue = 2.0
				slider.addTarget(self, action: #selector(handleSliderValueChange), for: UIControl.Event.valueChanged)
                slider.sliderIdentifier = 200
                
            default:
                value = volume
                
                keyLabel?.text = "Volume"
				valueLabel?.text = NSString(format: "%.2f", volume) as String
                slider.minimumValue = 0.0
                slider.maximumValue = 1.0
				slider.addTarget(self, action: #selector(handleSliderValueChange), for: UIControl.Event.valueChanged)
                slider.sliderIdentifier = 300
            }
            
            
            if slider.value != value {
                slider.value = value
            }
        }
        else{
			cell = tableView.dequeueReusableCell(withIdentifier: "idCellVoicePicker", for: indexPath) as UITableViewCell
            
			let pickerView = cell.contentView.viewWithTag(10) as! UIPickerView
            pickerView.delegate = self
            pickerView.dataSource = self
        }
        
        return cell
    }
 
    
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return 100.0
        }
        else{
            return 170.0
        }
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func saveSettings(sender: AnyObject) {
		UserDefaults.standard.set(rate, forKey: "rate")
		UserDefaults.standard.set(pitch, forKey: "pitch")
		UserDefaults.standard.set(volume, forKey: "volume")
		UserDefaults.standard.set(arrVoiceLanguages[selectedVoiceLanguage]["languageCode"]!, forKey: "languageCode")
		UserDefaults.standard.synchronize()
        
        self.delegate.didSaveSettings()
        
		navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Custom method implementation
    
	@objc func handleSliderValueChange(sender: CustomSlider) {
        
        switch sender.sliderIdentifier {
        case 100:
            rate = sender.value
            
        case 200:
            pitch = sender.value
            
        default:
            volume = sender.value
        }
        
        tbSettings.reloadData()
    }
    
    
    func prepareVoiceList() {
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            let voiceLanguageCode = (voice as AVSpeechSynthesisVoice).language
            
			let languageName = (Locale.current as NSLocale).displayName(forKey:NSLocale.Key.identifier, value: voiceLanguageCode)
            
            let dictionary = ["languageName": languageName, "languageCode": voiceLanguageCode]
            
            arrVoiceLanguages.append(dictionary)
        }
    }
    
    
    
    // MARK: UIPickerView method implementation
    
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrVoiceLanguages.count
    }
    
    
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let voiceLanguagesDictionary = arrVoiceLanguages[row]
        
        return voiceLanguagesDictionary["languageName"]!
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedVoiceLanguage = row
    }
    
}
