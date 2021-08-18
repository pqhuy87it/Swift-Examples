//
//  ViewController.swift
//  CameraFrameExtractor
//
//  Created by Anand Nigam on 11/10/18.
//  Copyright © 2018 Anand Nigam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var cameraPreview: UIView!
    @IBOutlet weak var photoGuideView: UIView!
    
    
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    let context = CIContext()
    
    /// This will be true when the user clicks on the click photo button.
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        view.addSubview(cameraPreview)
        self.setUpAVCapture()
        self.photoGuideView.layer.borderWidth = 2.0
        self.photoGuideView.layer.borderColor = UIColor.red.cgColor
        self.view.bringSubviewToFront(self.photoGuideView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCamera()
    }

    // To add the layer of your preview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.cameraPreview.layer.bounds
    }
    
    // To set the camera and its position to capture
    func setUpAVCapture() {
        session.sessionPreset = AVCaptureSession.Preset.photo//AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice
            .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                     for: .video,
                     position: AVCaptureDevice.Position.back) else {
                        return
        }
        captureDevice = device
        beginSession()
    }
    
    // Function to setup the beginning of the capture session
    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: cant get deviceInput")
                return
            }
            
            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }
            
            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)
            
            if session.canAddOutput(self.videoDataOutput){
                session.addOutput(self.videoDataOutput)
            }
            
            videoDataOutput.connection(with: .video)?.isEnabled = true
            
            previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            let rootLayer :CALayer = self.cameraPreview.layer
            rootLayer.masksToBounds=true
            
            rootLayer.addSublayer(self.previewLayer)
            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }
    
    // Function to capture the frames again and again
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection.isVideoOrientationSupported {
            connection.videoOrientation = .portrait
        }
        // do stuff here
        DispatchQueue.main.async { [unowned self] in
            
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
            
            guard let image = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
//            guard let image = self.getImageFromSampleBuffer(buffer: sampleBuffer, orientation: orientation) else { return }
            
            if takePhoto {
                takePhoto = false
                /// Other way
//                let cropRect = makeProportionalCropRect()
//                let resizedCropRect = CGRect(x: (image.size.width) * cropRect.origin.x,
//                                             y: (image.size.height) * cropRect.origin.y,
//                                             width: (image.size.width * cropRect.width),
//                                             height: (image.size.height * cropRect.height))
//                let newImage = image.crop(rect: resizedCropRect)
                
                let newImage = self.crop(image)
                print(newImage)
            }
        }
        
    }
    
    // Function to process the buffer and return UIImage to be used
    func imageFromSampleBuffer(sampleBuffer : CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        
        
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
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
    
    // To stop the session 
    func stopCamera(){
        session.stopRunning()
    }

    @IBAction func capturePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    private func makeProportionalCropRect() -> CGRect {
        let cropRect = photoGuideView.frame
        
        let normalizedX = max(0, cropRect.origin.x / cameraPreview.frame.width)
        let normalizedY = max(0, cropRect.origin.y / cameraPreview.frame.height)
        
        let extraWidth = min(0, cropRect.origin.x)
        let extraHeight = min(0, cropRect.origin.y)
        
        let normalizedWidth = min(1, (cropRect.width + extraWidth) / cameraPreview.frame.width)
        let normalizedHeight = min(1, (cropRect.height + extraHeight) / cameraPreview.frame.height)
        
        return CGRect(x: normalizedX, y: normalizedY, width: normalizedWidth, height: normalizedHeight)
    }

    //MARK: - cropping done here
    private func crop(_ image: UIImage) -> UIImage? {
        let imageSize = image.size
        let width = photoGuideView.frame.width / cameraPreview.frame.height
        let height = photoGuideView.frame.height / cameraPreview.frame.height
        let x = (photoGuideView.frame.origin.x - cameraPreview.frame.origin.x) / cameraPreview.frame.width
        let y = (photoGuideView.frame.origin.y - cameraPreview.frame.origin.y) / cameraPreview.frame.height
        
        let cropFrame = CGRect(x: x * imageSize.height,
                               y: y * imageSize.height,
                               width: imageSize.height * width,
                               height: imageSize.height * height)
        if let cropCGImage = image.cgImage?.cropping(to: cropFrame) {
            let cropImage = UIImage(cgImage: cropCGImage, scale: 1, orientation: .up)
            return cropImage
        }
        return nil
    }
}

extension UIImage {
    
    func crop(rect: CGRect) -> UIImage {
        
        func radians(_ degrees: CGFloat) -> CGFloat {
            return degrees / 180 * .pi
        }
        
        var rectTransform: CGAffineTransform
        switch imageOrientation {
            case .left:
                rectTransform = CGAffineTransform(rotationAngle: radians(90)).translatedBy(x: 0, y: -size.height)
            case .right:
                rectTransform = CGAffineTransform(rotationAngle: radians(-90)).translatedBy(x: -size.width, y: 0)
            case .down:
                rectTransform = CGAffineTransform(rotationAngle: radians(-180)).translatedBy(x: -size.width, y: -size.height)
            default:
                rectTransform = CGAffineTransform.identity
        }
        
        rectTransform = rectTransform.scaledBy(x: scale, y: scale)
        
        if let cropped = cgImage?.cropping(to: rect.applying(rectTransform)) {
            return UIImage(cgImage: cropped, scale: scale, orientation: imageOrientation).fixOrientation()
        }
        
        return self
    }
    
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
}


