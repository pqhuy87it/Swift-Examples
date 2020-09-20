//
//  ViewController.swift
//  PhotoLibrary
//
//  Created by Pham Quang Huy on 7/26/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnCameraPressed(_ sender: Any) {
        self.showImagePickerController()
    }
    
    func checkPhotoLibraryAuthorization() -> Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            return true
        case .denied:
            return false
        case .restricted:
            return false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({[weak self](status) in
                guard let  strongself = self else {
                    return
                }
                
                if status == .authorized {
                    DispatchQueue.main.async(execute: { () -> Void in
                        strongself.showImagePickerController()
                    })
                }
            })
            
            return false
        case .limited:
            return false
            @unknown default:
            fatalError()
        }
    }
    
    func showImagePickerController() {
        guard self.checkPhotoLibraryAuthorization() else {
            return
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            imagePickerController.allowsEditing = false
            imagePickerController.videoQuality = .typeHigh
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType.rawValue] as? String {
            switch mediaType {
            case String(kUTTypeImage):
                if let pickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
                    print("picked image size \(pickedImage.size)")
                }
            case String(kUTTypeMovie):
                if let pickedVideoURL = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? NSURL {
                    
                    if let videoData = NSData(contentsOf: pickedVideoURL as URL) {
                        print("picked video data: \(videoData.length)")

                    }
                }
            default:
                break
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

