//
//  ViewController.swift
//  Weight
//
//  Created by USER on 2021/03/01.
//

import UIKit

class CameraViewController: UIViewController {
    
    private let captureSessionManager = CaptureSessionManager()
    
    private var cameraView: CameraView {
        get {
            self.view as! CameraView
        }
        
        set {
            self.view = newValue
        }
    }
    
    override func loadView() {
        self.cameraView = CameraView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSessionManager.setUpSession()
        cameraView.captureSession = captureSessionManager.session
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSessionManager.startCapture(onNotAuthorized: {
            self.presentAuthorizationAlert()
        }, onConfigurationFailed: {
            self.presentConfigErrorAlert()
        })
    
    }
    
    private func presentAuthorizationAlert() {
        DispatchQueue.main.async {
            let changePrivacySetting = "카메라 권한이 없습니다. 권한을 변경해주세요!"
            let message = NSLocalizedString(changePrivacySetting, comment: "카메라 권한 획득 불가")
            let alertController = UIAlertController(title: "Weight", message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Alert button to open Settings"),
                                                    style: .`default`,
                                                    handler: { _ in
                                                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                                  options: [:],
                                                                                  completionHandler: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func presentConfigErrorAlert() {
        DispatchQueue.main.async {
            let alertMsg = "카메라 설정에 문제"
            let message = NSLocalizedString("카메라 설정에 문제가 발생했습니다.", comment: alertMsg)
            let alertController = UIAlertController(title: "Weight", message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"),
                                                    style: .cancel,
                                                    handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

