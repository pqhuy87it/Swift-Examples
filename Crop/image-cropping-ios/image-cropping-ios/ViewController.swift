//
//  ViewController.swift
//  croppingImage
//
//  Created by 服部穣 on 2019/02/09.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        
        selectImageButton1.frame = CGRect(x: viewWidth / 5, y: viewHeight * 3/5, width: viewWidth * 3/5, height: viewHeight / 8)
        selectImageButton1.setTitle("select image and crop with method 1", for: .normal)
        selectImageButton1.layer.borderColor = UIColor.black.cgColor
        selectImageButton1.backgroundColor = .blue
        selectImageButton1.addTarget(self, action: #selector(selectImage1), for: .touchUpInside)
        selectImageButton1.titleLabel?.numberOfLines = 0
        view.addSubview(selectImageButton1)
        
        selectImageButton2.frame = CGRect(x: viewWidth / 5, y: viewHeight * 4/5, width: viewWidth * 3/5, height: viewHeight / 8)
        selectImageButton2.setTitle("select image and crop with method 2", for: .normal)
        selectImageButton2.layer.borderColor = UIColor.black.cgColor
        selectImageButton2.backgroundColor = .blue
        selectImageButton2.addTarget(self, action: #selector(selectImage2), for: .touchUpInside)
        selectImageButton2.titleLabel?.numberOfLines = 0
        view.addSubview(selectImageButton2)
        
        imageView.frame = CGRect(x: viewWidth / 5, y: viewHeight / 10, width: viewWidth * 3 / 5, height: viewHeight * 2/5)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    let imageView = UIImageView()
    let imagePicker = UIImagePickerController()
    let selectImageButton1 = UIButton()
    let selectImageButton2 = UIButton()
    
    // change this value as you want!
    var useFirstCroppingMethod = true
    
    @objc func selectImage1() {
        
        useFirstCroppingMethod = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func selectImage2() {
        
        useFirstCroppingMethod = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            image = possibleImage
        } else {
            return
        }
        
        // change this value as you want!
        let rectToCrop = CGRect(x: 10, y: 50, width: 150, height: 150)
        let croppedImage: UIImage
        
        if useFirstCroppingMethod {
            let factor = imageView.frame.width/image.size.width
            let rect = CGRect(x: rectToCrop.origin.x / factor, y: rectToCrop.origin.y / factor, width: rectToCrop.width / factor, height: rectToCrop.height / factor)
            croppedImage = cropImage1(image: image, rect: rect)
        } else {
            let scale = imageView.frame.width/image.size.width
            croppedImage = cropImage2(image: image, rect: rectToCrop, scale: scale)
        }
        
        imageView.image = image
        let originalFrame = imageView.frame
        let croppedFrame = CGRect(x: originalFrame.origin.x + rectToCrop.origin.x, y: originalFrame.origin.y + rectToCrop.origin.y, width: rectToCrop.width, height: rectToCrop.height)
        
        dismiss(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: { [unowned self] in
            
            self.imageView.image = croppedImage
            self.imageView.frame = croppedFrame
            UIView.animate(withDuration: 1.0) { [unowned self] in
                self.imageView.frame = originalFrame
            }
        })
    }
    
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage!
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!, scale: image.scale, orientation: image.imageOrientation)
    }
    
    func cropImage2(image: UIImage, rect: CGRect, scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width / scale, height: rect.size.height / scale), true, 0.0)
        image.draw(at: CGPoint(x: -rect.origin.x / scale, y: -rect.origin.y / scale))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage!
    }
}


