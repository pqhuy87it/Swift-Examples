//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    let startButton = UIButton()
    let pauseButton = UIButton()
    let stopButton = UIButton()
    let resetButton = UIButton()
    let reverseButton = UIButton()
    let slider = UISlider()
    
    let rect = UIView()
    
    let propertyAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 5.0, curve: UIView.AnimationCurve.easeInOut)
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        rect.frame = CGRect(x: 0, y: 50, width: 100, height: 100)
        rect.backgroundColor = UIColor.red
        view.addSubview(rect)
        
        startButton.frame = CGRect(x: 50, y: 300, width: 60, height: 30)
        startButton.setTitle("Start", for: UIControl.State.normal)
        startButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        startButton.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        startButton.addTarget(self, action: #selector(startAnimation), for: UIControl.Event.touchUpInside)
        view.addSubview(startButton)
        
        pauseButton.frame = CGRect(x: 120, y: 300, width: 60, height: 30)
        pauseButton.setTitle("Pause", for: UIControl.State.normal)
        pauseButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        pauseButton.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        pauseButton.isEnabled = false
        pauseButton.addTarget(self, action: #selector(pauseAnimation), for: UIControl.Event.touchUpInside)
        view.addSubview(pauseButton)
        
        stopButton.frame = CGRect(x: 190, y: 300, width: 60, height: 30)
        stopButton.setTitle("Stop", for: UIControl.State.normal)
        stopButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        stopButton.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        stopButton.isEnabled = false
        stopButton.addTarget(self, action: #selector(stopAnimation), for: UIControl.Event.touchUpInside)
        view.addSubview(stopButton)
        
        resetButton.frame = CGRect(x: 260, y: 300, width: 60, height: 30)
        resetButton.setTitle("Reset", for: UIControl.State.normal)
        resetButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        resetButton.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        resetButton.isEnabled = false
        resetButton.addTarget(self, action: #selector(resetAnimation), for: UIControl.Event.touchUpInside)
        view.addSubview(resetButton)
        
        reverseButton.frame = CGRect(x: 50, y: 360, width: 80, height: 30)
        reverseButton.setTitle("Reverse", for: UIControl.State.normal)
        reverseButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        reverseButton.setTitleColor(UIColor.gray, for: UIControl.State.disabled)
        reverseButton.isEnabled = false
        reverseButton.addTarget(self, action: #selector(reverseAnimation), for: UIControl.Event.touchUpInside)
        view.addSubview(reverseButton)
        
        slider.frame = CGRect(x: 50, y: 400, width: 200, height: 30)
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        view.addSubview(slider)
        
        propertyAnimator.addAnimations {
            self.rect.center.x = 300
        }
        
    }
    
    @objc func startAnimation() {
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        stopButton.isEnabled = true
        reverseButton.isEnabled = true
        propertyAnimator.startAnimation()
    }
    
    @objc func pauseAnimation() {
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        stopButton.isEnabled = true
        reverseButton.isEnabled = false
        propertyAnimator.pauseAnimation()
        slider.value = Float(propertyAnimator.fractionComplete)
    }
    
    @objc func stopAnimation() {
        stopButton.isEnabled = false
        startButton.isEnabled = false
        pauseButton.isEnabled = false
        resetButton.isEnabled = true
        reverseButton.isEnabled = false
        propertyAnimator.stopAnimation(false)
        propertyAnimator.finishAnimation(at: .current)
        slider.value = Float(propertyAnimator.fractionComplete)
    }
    
    @objc func resetAnimation() {
        self.rect.center.x = 50
        propertyAnimator.addAnimations {
            self.rect.center.x = 300
        }
        startButton.isEnabled = true
        resetButton.isEnabled = false
        reverseButton.isEnabled = false
        slider.value = 0
    }
    
    @objc func reverseAnimation() {
        if (propertyAnimator.isRunning) {
            propertyAnimator.isReversed = true
        }
        
        reverseButton.isEnabled = false
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        if propertyAnimator.isRunning {
            propertyAnimator.pauseAnimation()
        }
        propertyAnimator.fractionComplete = CGFloat(sender.value)
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
