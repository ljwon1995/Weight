//
//  CameraView.swift
//  Weight
//
//  Created by J.won on 2022/02/04.
//

import UIKit
import AVFoundation

class CameraView: UIView {
    
    private var cameraViewLayer: AVCaptureVideoPreviewLayer {
        self.layer as! AVCaptureVideoPreviewLayer
    }
    
    var captureSession: AVCaptureSession? {
        get {
            cameraViewLayer.session
        }
        
        set {
            cameraViewLayer.session = newValue
        }
    }
    
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.cameraViewLayer.videoGravity = .resizeAspectFill
    }
    
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
}
