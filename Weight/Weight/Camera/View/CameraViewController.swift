//
//  CameraViewController.swift
//  Weight
//
//  Created by USER on 2021/03/01.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker: UIImagePickerController = UIImagePickerController()
    var isFirstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isFirstTime {
            presentCameraView()
            isFirstTime = false
        }
    }
    
    func presentCameraView() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            present(imagePicker, animated: false, completion: nil)
        }
    }
}
