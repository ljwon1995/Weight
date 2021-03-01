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
    var isAppearFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isAppearFirst {
            presentCameraView()
            isAppearFirst = false
        } else {
            presentDataView()
        }
    }
    
    func presentCameraView() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            present(imagePicker, animated: false, completion: nil)
        }
    }
    
    func presentDataView() {
        let dataStoryboard = UIStoryboard(name: "Data", bundle: nil)
        let dataViewController = dataStoryboard.instantiateViewController(identifier: "Data")
        self.navigationController?.pushViewController(dataViewController, animated: true)
    }
}
