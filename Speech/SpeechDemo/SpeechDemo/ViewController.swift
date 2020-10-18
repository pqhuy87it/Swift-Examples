//
//  ViewController.swift
//  SpeechDemo
//
//  Created by Gabriel Theodoropoulos on 2/10/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate, SettingsViewControllerDelegate {

    @IBOutlet weak var tvEditor: UITextView!
    
    @IBOutlet weak var btnSpeak: UIButton!
    
    @IBOutlet weak var btnPause: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var pvSpeechProgress: UIProgressView!
    
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var rate: Float!
    
    var pitch: Float!
    
    var volume: Float!
    
    var totalUtterances: Int! = 0
    
    var currentUtterance: Int! = 0
    
    var totalTextLength: Int = 0
    
    var spokenTextLengths: Int = 0
    
    var preferredVoiceLanguageCode: String!
    
    var previousSelectedRange: NSRange!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make the corners of the textview rounded and the buttons look like circles.
        tvEditor.layer.cornerRadius = 15.0
        btnSpeak.layer.cornerRadius = 40.0
        btnPause.layer.cornerRadius = 40.0
        btnStop.layer.cornerRadius = 40.0
        
        // Set the initial alpha value of the following buttons to zero (make them invisible).
        btnPause.alpha = 0.0
        btnStop.alpha = 0.0
        
        // Make the progress view invisible and set is initial progress to zero.
        pvSpeechProgress.alpha = 0.0
        pvSpeechProgress.progress = 0.0
        
        // Create a swipe down gesture for hiding the keyboard.
		let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDownGesture))
		swipeDownGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
        
        
        if !loadSettings() {
            registerDefaultSettings()
        }
        
        speechSynthesizer.delegate = self
        
        setInitialFontAttribute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idSegueSettings" {
			let settingsViewController = segue.destination as! SettingsViewController
            settingsViewController.delegate = self
        }    
    }
    
    
    // MARK: Custom method implementation
    
	@objc func handleSwipeDownGesture(gestureRecognizer: UISwipeGestureRecognizer) {
        tvEditor.resignFirstResponder()
    }
    
    
    func registerDefaultSettings() {
        rate = AVSpeechUtteranceDefaultSpeechRate
        pitch = 1.0
        volume = 1.0
        
        let defaultSpeechSettings = ["rate": rate, "pitch": pitch, "volume": volume]
        
		UserDefaults.standard.register(defaults: defaultSpeechSettings as [String : Any])
    }
    
    
    func loadSettings() -> Bool {
		let userDefaults = UserDefaults.standard
        
		if let theRate: Float = userDefaults.value(forKey: "rate") as? Float {
            rate = theRate
			pitch = userDefaults.value(forKey: "pitch") as? Float
			volume = userDefaults.value(forKey: "volume") as? Float
            
            return true
        }
        
        return false
    }
    
    
    func animateActionButtonAppearance(_ shouldHideSpeakButton: Bool) {
        var speakButtonAlphaValue: CGFloat = 1.0
        var pauseStopButtonsAlphaValue: CGFloat = 0.0
        
        if shouldHideSpeakButton {
            speakButtonAlphaValue = 0.0
            pauseStopButtonsAlphaValue = 1.0
        }
        
		UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.btnSpeak.alpha = speakButtonAlphaValue
            
            self.btnPause.alpha = pauseStopButtonsAlphaValue
            
            self.btnStop.alpha = pauseStopButtonsAlphaValue
            
            self.pvSpeechProgress.alpha = pauseStopButtonsAlphaValue
        })
    }
    
    
    func setInitialFontAttribute() {
		let rangeOfWholeText = NSMakeRange(0, tvEditor.text.utf16.count)
        let attributedText = NSMutableAttributedString(string: tvEditor.text)
		attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Arial", size: 18.0)!, range: rangeOfWholeText)
        tvEditor.textStorage.beginEditing()
		tvEditor.textStorage.replaceCharacters(in: rangeOfWholeText, with: attributedText)
        tvEditor.textStorage.endEditing()
    }
    
    
    func unselectLastWord() {
        if let selectedRange = previousSelectedRange {
            // Get the attributes of the last selected attributed word.
			let currentAttributes = tvEditor.attributedText.attributes(at: selectedRange.location, effectiveRange: nil)
            // Keep the font attribute.
			let fontAttribute: AnyObject? = currentAttributes[NSAttributedString.Key.font] as AnyObject
            
            // Create a new mutable attributed string using the last selected word.
			let attributedWord = NSMutableAttributedString(string: tvEditor.attributedText.attributedSubstring(from: selectedRange).string)
            
            // Set the previous font attribute, and make the foreground color black.
			attributedWord.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, attributedWord.length))
			attributedWord.addAttribute(NSAttributedString.Key.font, value: fontAttribute!, range: NSMakeRange(0, attributedWord.length))
            
            // Update the text storage property and replace the last selected word with the new attributed string.
            tvEditor.textStorage.beginEditing()
			tvEditor.textStorage.replaceCharacters(in: selectedRange, with: attributedWord)
            tvEditor.textStorage.endEditing()
        }
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func speak(sender: AnyObject) {
		if !speechSynthesizer.isSpeaking {
            /**
            let speechUtterance = AVSpeechUtterance(string: tvEditor.text)
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitch
            speechUtterance.volume = volume
            speechSynthesizer.speakUtterance(speechUtterance)
            */

            let textParagraphs = tvEditor.text.components(separatedBy: "\n")
            
            totalUtterances = textParagraphs.count
            currentUtterance = 0
            totalTextLength = 0
            spokenTextLengths = 0
            
            for pieceOfText in textParagraphs {
                let speechUtterance = AVSpeechUtterance(string: pieceOfText)
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitch
                speechUtterance.volume = volume
                speechUtterance.postUtteranceDelay = 0.005
                
                if let voiceLanguageCode = preferredVoiceLanguageCode {
                    let voice = AVSpeechSynthesisVoice(language: voiceLanguageCode)
                    speechUtterance.voice = voice
                }
                
				totalTextLength = totalTextLength + pieceOfText.utf16.count
                
				speechSynthesizer.speak(speechUtterance)
            }
            
            
        }
        else{
            speechSynthesizer.continueSpeaking()
        }
        
        animateActionButtonAppearance(true)
    }
    
    
    @IBAction func pauseSpeech(sender: AnyObject) {
		speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
        animateActionButtonAppearance(false)
    }
    
    
    @IBAction func stopSpeech(sender: AnyObject) {
		speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        animateActionButtonAppearance(false)
    }
    
    
 
    // MARK: AVSpeechSynthesizerDelegate method implementation
    
	func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		spokenTextLengths = spokenTextLengths + utterance.speechString.utf16.count + 1
        
        let progress: Float = Float(spokenTextLengths * 100 / totalTextLength)
        pvSpeechProgress.progress = progress / 100
        
        if currentUtterance == totalUtterances {
            animateActionButtonAppearance(false)
            
            unselectLastWord()
            previousSelectedRange = nil
        }
    }
    
    
	func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        currentUtterance = currentUtterance + 1
    }
    
    
	func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let progress: Float = Float(spokenTextLengths + characterRange.location) * 100 / Float(totalTextLength)
        pvSpeechProgress.progress = progress / 100
    
        
        // Determine the current range in the whole text (all utterances), not just the current one.
        let rangeInTotalText = NSMakeRange(spokenTextLengths + characterRange.location, characterRange.length)
        
        // Select the specified range in the textfield.
        tvEditor.selectedRange = rangeInTotalText
        
        // Store temporarily the current font attribute of the selected text.
		let currentAttributes = tvEditor.attributedText.attributes(at: rangeInTotalText.location, effectiveRange: nil)
		let fontAttribute: AnyObject? = currentAttributes[NSAttributedString.Key.font] as AnyObject
        
        // Assign the selected text to a mutable attributed string.
		let attributedString = NSMutableAttributedString(string: tvEditor.attributedText.attributedSubstring(from: rangeInTotalText).string)
        
        // Make the text of the selected area orange by specifying a new attribute.
		attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSMakeRange(0, attributedString.length))
        
        // Make sure that the text will keep the original font by setting it as an attribute.
		attributedString.addAttribute(NSAttributedString.Key.font, value: fontAttribute!, range: NSMakeRange(0, attributedString.string.utf16.count))
        
        // In case the selected word is not visible scroll a bit to fix this.
        tvEditor.scrollRangeToVisible(rangeInTotalText)
        
        // Begin editing the text storage.
        tvEditor.textStorage.beginEditing()
        
        // Replace the selected text with the new one having the orange color attribute.
		tvEditor.textStorage.replaceCharacters(in: rangeInTotalText, with: attributedString)
        
        // If there was another highlighted word previously (orange text color), then do exactly the same things as above and change the foreground color to black.
        if let previousRange = previousSelectedRange {
			let previousAttributedText = NSMutableAttributedString(string: tvEditor.attributedText.attributedSubstring(from: previousRange).string)
			previousAttributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, previousAttributedText.length))
			previousAttributedText.addAttribute(NSAttributedString.Key.font, value: fontAttribute!, range: NSMakeRange(0, previousAttributedText.length))
            
			tvEditor.textStorage.replaceCharacters(in: previousRange, with: previousAttributedText)
        }
        
        // End editing the text storage.
        tvEditor.textStorage.endEditing()
        
        // Keep the currently selected range so as to remove the orange text color next.
        previousSelectedRange = rangeInTotalText
    }
    
    
    // MARK: SettingsViewControllerDelegate method implementation
    
    func didSaveSettings() {
		let settings = UserDefaults.standard
        
		rate = settings.value(forKey: "rate") as? Float
		pitch = settings.value(forKey: "pitch") as? Float
		volume = settings.value(forKey: "volume") as? Float
        
		preferredVoiceLanguageCode = settings.object(forKey: "languageCode") as? String
    }
    
}

