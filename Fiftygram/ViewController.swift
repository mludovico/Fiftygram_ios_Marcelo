//
//  ViewController.swift
//  Fiftygram
//
//  Created by marcelo on 19/12/2020.
//  Copyright © 2020 marcelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let context = CIContext()
    var original: UIImage?
    
    @IBOutlet var imageView: UIImageView!

    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }

    @IBAction func applySepia() {
        let filter = CIFilter(name: "CISepiaTone")
        display(filter: filter!)
    }
    
    @IBAction func applyNoir() {
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    @IBAction func applyVintage() {
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    @IBAction func applyMonochrome() {
        let filter = CIFilter(name: "CIColorMonochrome")
        let color: CIColor = CIColor(red: 0, green: 0, blue: 255)
        filter?.setValue(color, forKey: kCIInputColorKey)
        display(filter: filter!)
    }
    
    @IBAction func applyInvert() {
        let filter = CIFilter(name: "CIColorInvert")
        display(filter: filter!)
    }
    
    @IBAction func applyPixelate() {
        let filter = CIFilter(name: "CIPixellate")
        filter?.setValue(32, forKey: kCIInputScaleKey)
        display(filter: filter!)
    }
    
    @IBAction func applyPosterize() {
        let filter = CIFilter(name: "CIColorPosterize")
        display(filter: filter!)
    }
    
    func display(filter: CIFilter) {
        guard let original = original else {
            return
        }
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    @IBAction func save() {
        guard let image = imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
        if let image =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                original = image
                imageView.image = original
            }
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

