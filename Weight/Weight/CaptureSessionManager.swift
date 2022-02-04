//
//  CaptureSessionManager.swift
//  Weight
//
//  Created by J.won on 2022/02/04.
//

import AVFoundation
import UIKit

class CaptureSessionManager {
    
    enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
    
    
    var session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "session queue")
    private var sessionSetupResult: SessionSetupResult = .success
    
    func startCapture(onNotAuthorized: @escaping  () -> Void, onConfigurationFailed: @escaping () -> Void) {
        sessionQueue.async {
            switch self.sessionSetupResult {
            case .success:
                self.session.startRunning()
            case .notAuthorized:
                onNotAuthorized()
                
            case .configurationFailed:
                onConfigurationFailed()
            }
        }
    }
    
    func setUpSession() {
        
        sessionQueue.async {
            self.checkAndRequestAuthorization()
        }
        
        sessionQueue.async {
            
            guard self.sessionSetupResult == .success else { return }

            self.session.beginConfiguration()
            
            defer { self.session.commitConfiguration()}
            
            guard let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let cameraDeviceInput = try? AVCaptureDeviceInput(device: cameraDevice),
                  self.session.canAddInput(cameraDeviceInput) else {
                      self.sessionSetupResult = .configurationFailed
                      return
                  }
            
            self.session.addInput(cameraDeviceInput)
            
            let photoOutput = AVCapturePhotoOutput()
            
            guard self.session.canAddOutput(photoOutput) else {
                self.sessionSetupResult = .configurationFailed
                return
            }
            
            self.session.sessionPreset = .medium
            
            self.session.addOutput(photoOutput)
            
        }
    }
    
    private func checkAndRequestAuthorization() {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return
            
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    self.sessionSetupResult = .notAuthorized
                }
                self.sessionQueue.resume()
            }
            
        default:
            sessionSetupResult = .notAuthorized
        }
        
    }
}
