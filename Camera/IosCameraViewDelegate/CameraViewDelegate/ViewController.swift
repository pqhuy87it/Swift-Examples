//
//  ViewController.swift
//  CameraViewDelegate
//
//  Created by tayutaedomo on 2019/08/21.
//  Copyright © 2019 tayutaedomo.net. All rights reserved.
//

import UIKit
import AVFoundation

//
// Refer: https://codeday.me/jp/qa/20190503/766457.html
//
class ViewController: UIViewController {

    // MARK: Properties
    var video_data_output: AVCaptureVideoDataOutput!
    var video_data_output_queue: DispatchQueue!
    var preview_layer: AVCaptureVideoPreviewLayer!
    var capture_device: AVCaptureDevice!
    let session = AVCaptureSession()
    var current_frame: CIImage!
    var done = false


    // MARK: - IBOutlets
    @IBOutlet weak var camera_view: UIView!


    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setup_avcapture()

        //preview_view.contentMode = UIViewContentMode.scaleAspectFit
        preview_layer?.position = CGPoint(x: camera_view.frame.width/2, y: camera_view.frame.height/2)
    }

    override func viewWillAppear(_ animated: Bool) {
        if !done {
            session.startRunning()
        }
    }

    // ???
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // ???
    override var shouldAutorotate: Bool {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
            UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
            UIDevice.current.orientation == UIDeviceOrientation.unknown) {
            return false
        }
        else {
            return true
        }
    }
}


extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        current_frame = convert_image_from_cm_sample_buffer_ref(sampleBuffer)
    }


    func setup_avcapture() {
        session.sessionPreset = AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        capture_device = device
        begin_session()
        done = true
    }

    func begin_session() {
        var device_input: AVCaptureDeviceInput!
        do {
            device_input = try AVCaptureDeviceInput(device: capture_device)
            guard device_input != nil else {
                print("error: cant get deviceInput")
                return
            }

            if session.canAddInput(device_input) {
                session.addInput(device_input)
            }

            video_data_output = AVCaptureVideoDataOutput()
            video_data_output.alwaysDiscardsLateVideoFrames = true // ???
            video_data_output_queue = DispatchQueue(label: "VideoDataOutputQueue") // ???
            video_data_output.setSampleBufferDelegate(self, queue: video_data_output_queue)

            if session.canAddOutput(video_data_output) {
                session.addOutput(video_data_output)
            }

            video_data_output.connection(with: AVMediaType.video)?.isEnabled = true

            preview_layer = AVCaptureVideoPreviewLayer(session: session)
            preview_layer.videoGravity = AVLayerVideoGravity.resizeAspect

            let root_layer: CALayer = self.camera_view.layer
            root_layer.masksToBounds = true // ???
            preview_layer.frame = root_layer.bounds
            root_layer.addSublayer(preview_layer)

            session.startRunning()
        }
        catch let error as NSError {
            device_input = nil
            print("error: \(error.localizedDescription)")
        }
    }

    func stop_camera() {
        session.stopRunning()
        done = false
    }

    func convert_image_from_cm_sample_buffer_ref(_ sample_buffer: CMSampleBuffer) -> CIImage {
        let pixel_buffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sample_buffer)!
        let ci_image: CIImage = CIImage(cvImageBuffer: pixel_buffer)
        return ci_image
    }
}
