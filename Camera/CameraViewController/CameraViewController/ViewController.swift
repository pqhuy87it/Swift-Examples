//
//  ViewController.swift
//  CameraViewController
//
//  Created by mybkhn on 2021/02/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

	@IBOutlet weak var myView: UIView!

	var session: AVCaptureSession?
	var device: AVCaptureDevice?
	var input: AVCaptureDeviceInput?
	var output: AVCaptureMetadataOutput?
	var prevLayer: AVCaptureVideoPreviewLayer?

	override func viewDidLoad() {
		super.viewDidLoad()
		createSession()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		prevLayer?.frame.size = myView.frame.size
	}

	func createSession() {
		session = AVCaptureSession()
		device = AVCaptureDevice.default(for: AVMediaType.video)

		do {
			input = try AVCaptureDeviceInput(device: device!)
		} catch {}

		session?.addInput(input!)

		prevLayer = AVCaptureVideoPreviewLayer(session: session!)
		prevLayer?.frame.size = myView.frame.size
		prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill

		prevLayer?.connection?.videoOrientation = transformOrientation(orientation: UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!)

		myView.layer.addSublayer(prevLayer!)

		session?.startRunning()
	}

	func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
		let devices = AVCaptureDevice.devices(for: AVMediaType.video)
		for device in devices {
			if device.position == position {
				return device
			}
		}
		return nil
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animate(alongsideTransition: { (context) -> Void in
			self.prevLayer?.connection?.videoOrientation = self.transformOrientation(orientation: UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!)
			self.prevLayer?.frame.size = self.myView.frame.size
		}, completion: { (context) -> Void in

		})
		super.viewWillTransition(to: size, with: coordinator)
	}

	func transformOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
		switch orientation {
		case .landscapeLeft:
			return .landscapeLeft
		case .landscapeRight:
			return .landscapeRight
		case .portraitUpsideDown:
			return .portraitUpsideDown
		default:
			return .portrait
		}
	}

	@IBAction func switchCameraSide(sender: AnyObject) {
		if let sess = session {
			let currentCameraInput: AVCaptureInput = sess.inputs[0]
			sess.removeInput(currentCameraInput)
			var newCamera: AVCaptureDevice
			if (currentCameraInput as! AVCaptureDeviceInput).device.position == .back {
				newCamera = self.cameraWithPosition(position: .front)!
			} else {
				newCamera = self.cameraWithPosition(position: .back)!
			}
			do {
				let newVideoInput = try AVCaptureDeviceInput(device: newCamera)
				session?.addInput(newVideoInput)
			} catch {}
		}
	}

}

