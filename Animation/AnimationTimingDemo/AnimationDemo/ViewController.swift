//
//  ViewController.swift
//  AnimationDemo
//
//  Created by MiaoChao on 16/6/13.
//  Copyright © 2016年 MiaoChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var displayLink: CADisplayLink?
    
    @IBOutlet weak var animatorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
    }
    
    // MARK: DisplayLink
    @IBAction func startDisplayLink(){
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(ViewController.handleDisplayLink(_:)))
            displayLink?.frameInterval = 5 // 即每刷新5帧调用一次
            displayLink?.add(to: RunLoop.current, forMode:RunLoop.Mode.common)
        }
        displayLink?.isPaused = false
    }
    
    @IBAction func stopDisplayLink(){
        displayLink?.isPaused = true
        displayLink?.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        print("displaylink last time : \(displayLink.timestamp)")
    }
    
    
    //MARK: CABasicAnimation
    @IBAction func startAnimation(sender: AnyObject) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = self
        let fromPoint = CGPoint(x: self.animatorView.center.x, y: self.animatorView.center.y)
        let toPoint = CGPoint(x: 300.0, y: 300.0)
        animation.fromValue = NSValue(cgPoint: fromPoint)
        animation.toValue = NSValue(cgPoint: toPoint)
        animation.duration = 5.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

//        animation.speed = 2.0 // 相对速度为2
//        animation.timeOffset = 0.0 //从2秒开始运动，然后再完成前2秒的动画，且与速度无关
//        animation.beginTime = CACurrentMediaTime() - 5.0 // 延时0.5秒开始
        self.animatorView.layer.add(animation, forKey: "KVCkey")
//        self.animatorView.layer.speed = 0.0
    }
    
    // MARK: 这两个方法还不是协议，而是NSObject的扩展
    // 为什么动画都已经结束了才开始调用这个方法
    func animationDidStart(_ anim: CAAnimation) {
        print("start view : \(String(describing: self.animatorView))")
        print("start view.layer : \(self.animatorView.layer.frame)")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim is CABasicAnimation {
            let animTemp = anim as! CABasicAnimation
            let toValue = animTemp.toValue
            let toValueTemp: NSValue = toValue as! NSValue
            var point = CGPoint(x: 0, y: 0)
            toValueTemp.getValue(&point)
            self.animatorView.center = point
        }
        
        print("end view : \(String(describing: self.animatorView))")
        print("end view.layer : \(self.animatorView.layer.frame)")
    }
    
    // MARK: 使用CAMediaTiming暂停动画
    @IBAction func pauseLayerAnimation(sender: AnyObject) {
        self.pauseLayer(layer: self.animatorView.layer)
    }

    @IBAction func resumeLayerAnimation(sender: AnyObject) {
        self.resumeLayer(layer: self.animatorView.layer)
    }
    
    @IBAction func changeBeginTime(sender: AnyObject) {
        self.changeLayerBeginTime(layer: self.animatorView.layer)
    }
    
    func pauseLayer(layer :CALayer){
        let pauseTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pauseTime
    }
    
    func resumeLayer(layer :CALayer){
        let pauseTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        layer.beginTime = timeSincePause + 2.0
    }
    
    // t = (tp - beginTime) * speed + timeOffset
    // 由上面的公式可以知：beginTime的取值范围一般是动画的duration区间，而不是真是的系统时间
    func changeLayerBeginTime(layer: CALayer) {
        layer.speed = 0.0;
        layer.beginTime += 1.0
        layer.speed = 1.0
    }
    
    var time:CFTimeInterval = 0.0
    @IBAction func sliderChangeAnimation(sender: AnyObject) {
        let slider = sender as! UISlider
        if time < 0.01 {
            // time的取值时间是由speed决定的，当speed不为0时就与父layer的时间相同
            time = self.animatorView.layer.convertTime(CACurrentMediaTime(), from: nil)
        }
        self.animatorView.layer.speed = 0.0
        self.animatorView.layer.timeOffset = Double(slider.value * 0.5) + time
        print("self.animatorView.layer.timeOffset : \(self.animatorView.layer.timeOffset)")
    }
    
    @IBAction func resetAnimationView(sender: AnyObject) {
        self.animatorView.center = CGPoint(x: 10, y: 20)
        self.animatorView.layer.speed = 1.0
        time = 0.0
    }
}

