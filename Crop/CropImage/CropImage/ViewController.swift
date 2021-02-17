//
//  ViewController.swift
//  CropImage
//
//  Created by Pham Quang Huy on 2021/02/14.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var cameraPreviewView: UIView!
    @IBOutlet weak var guideImageView: UIView!
    
    /// This will be true when the user clicks on the click photo button.
    var takePhoto = false
    
    var captureSession = AVCaptureSession()
    var previewLayer: CALayer!
    var captureDevice: AVCaptureDevice!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        captureSession = AVCaptureSession()
        previewLayer = CALayer()
        takePhoto = false
        
        requestAuthorization()
        
        self.guideImageView.layer.borderWidth = 2.0
        self.guideImageView.layer.borderColor = UIColor.red.cgColor
    }
    
    /// This function will request authorization, If authorized then start the camera.
    private func requestAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            case .authorized:
                prepareCamera()
                
            case .denied, .restricted, .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                    if !Thread.isMainThread {
                        DispatchQueue.main.async {
                            if granted {
                                self.prepareCamera()
                            } else {
                                let alert = UIAlertController(title: "unable_to_access_the_Camera", message: "to_enable_access_go_to_setting_privacy_camera_and_turn_on_camera_access_for_this_app", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {_ in
                                    self.navigationController?.popToRootViewController(animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    } else {
                        if granted {
                            self.prepareCamera()
                        } else {
                            let alert = UIAlertController(title: "unable_to_access_the_Camera", message: "to_enable_access_go_to_setting_privacy_camera_and_turn_on_camera_access_for_this_app", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {_ in
                                self.navigationController?.popToRootViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                })
            @unknown default:
                break
        }
    }
    
    /// Will see if the primary camera is avilable, If found will call method which will asign the available device to the AVCaptureDevice.
    private func prepareCamera() {
        // Resets the session.
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        if #available(iOS 10.0, *) {
            let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
            self.assignCamera(availableDevices)
        } else {
            // Fallback on earlier versions
            // development, need to test this on iOS 8
            if let availableDevices = AVCaptureDevice.default(for: AVMediaType.video) {
                self.assignCamera([availableDevices])
            } else {
                self.showAlert()
            }
        }
    }
    
    /// Assigns AVCaptureDevice to the respected the variable, will begin the session.
    ///
    /// - Parameter availableDevices: [AVCaptureDevice]
    private func assignCamera(_ availableDevices: [AVCaptureDevice]) {
        if availableDevices.first != nil {
            captureDevice = availableDevices.first
            beginSession()
        } else {
            self.showAlert()
        }
    }
    
    /// Configures the camera settings and begins the session, this function will be responsible for showing the image on the UI.
    private func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        self.previewLayer = previewLayer
        self.cameraPreviewView.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
//        self.previewLayer.frame.origin.y = +self.cameraPreviewView.frame.origin.y
//        (self.previewLayer as! AVCaptureVideoPreviewLayer).videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer.masksToBounds = true
        self.cameraPreviewView.clipsToBounds = true
        captureSession.startRunning()
        
        self.view.bringSubviewToFront(self.guideImageView)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String:kCVPixelFormatType_32BGRA]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "com.letsappit.camera")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Unable to access the camera", message: "It appears that either your device doesn't have camera or its broken", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {_ in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func capturePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    /// Get the UIImage from the given CMSampleBuffer.
    ///
    /// - Parameter buffer: CMSampleBuffer
    /// - Returns: UIImage?
    func getImageFromSampleBuffer(buffer:CMSampleBuffer, orientation: UIImage.Orientation) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: orientation)
                
            }
            
        }
        return nil
    }
}

extension UIImage {
    func imageByCropToRect(rect:CGRect, scale:Bool) -> UIImage {
        var rect = rect
        var scaleFactor: CGFloat = 1.0
        if scale  {
            scaleFactor = self.scale
            rect.origin.x *= scaleFactor
            rect.origin.y *= scaleFactor
            rect.size.width *= scaleFactor
            rect.size.height *= scaleFactor
        }
        
        var image: UIImage? = nil;
        if rect.size.width > 0 && rect.size.height > 0 {
            let imageRef = self.cgImage!.cropping(to: rect)
            image = UIImage(cgImage: imageRef!, scale: scaleFactor, orientation: self.imageOrientation)
        }
        
        return image!
    }
    
    func croppedInRect(rect: CGRect) -> UIImage? {
        func rad(_ degree: Double) -> CGFloat {
            return CGFloat(degree / 180.0 * .pi)
        }
        
        var rectTransform: CGAffineTransform
        switch imageOrientation {
            case .left:
                rectTransform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
            case .right:
                rectTransform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
            case .down:
                rectTransform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
            default:
                rectTransform = .identity
        }
        rectTransform = rectTransform.scaledBy(x: self.scale, y: self.scale)
        
        var cgImage = self.cgImage
        
        if cgImage == nil{
            
            let ciContext = CIContext()
            if let ciImage = self.ciImage{
                cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
            }
        }
        
        if let imageRef = cgImage?.cropping(to: rect.applying(rectTransform)){
            let result = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
            return result
        }
        
        
        return nil
        
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if connection.isVideoOrientationSupported {
            connection.videoOrientation = .portrait
        }
        
        if takePhoto {
            takePhoto = false
            
            // Rotation should be unlocked to work.
            var orientation = UIImage.Orientation.up
            switch UIDevice.current.orientation {
                case .landscapeLeft:
                    orientation = .left
                    
                case .landscapeRight:
                    orientation = .right
                    
                case .portraitUpsideDown:
                    orientation = .down
                    
                default:
                    orientation = .up
            }
            
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer, orientation: orientation) {
                DispatchQueue.main.async {
//                    let newImage = image.imageByCropToRect(rect: self.guideImageView.frame, scale: true)
                    let newImage = image.croppedInRect(rect: self.guideImageView.frame)
                    print(newImage)
//                    self.stopCaptureSession()
//                    self.previewLayer.removeFromSuperlayer()
//                    self.performSegue(withIdentifier: "showImage", sender: newImage)
                }
            }
        }
    }
}

