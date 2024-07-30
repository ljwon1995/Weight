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
    
    private let sessionQueue = DispatchQueue(label: "session queue")
    
    private var sessionSetupResult: SessionSetupResult = .success
    
    var session = AVCaptureSession()
    
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
    
    func setUpSession(delegate: WeightDetector) {
        
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
            
            let videoDataOutput = AVCaptureVideoDataOutput()
            
            videoDataOutput.setSampleBufferDelegate(delegate, queue: delegate.videoQueue)
            
            guard self.session.canAddOutput(videoDataOutput) else {
                self.sessionSetupResult = .configurationFailed
                return
            }
            
            self.session.sessionPreset = .high
            
            self.session.addOutput(videoDataOutput)

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
