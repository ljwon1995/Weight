//
//  WeightDetector.swift
//  Weight
//
//  Created by J.won on 2022/02/05.
//

import AVFoundation
import Vision

class WeightDetector: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private var isDetecting = false
    
    let videoQueue = DispatchQueue(label: "Video Queue")
    
    private var onSuccess: (String) -> Void = { _ in }
    
    func detectWeight(onSuccess: @escaping (String) -> Void) {
        videoQueue.async {
            self.isDetecting = true
            self.onSuccess = onSuccess
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        print("Dropped Frame Occur")
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        dispatchPrecondition(condition: .onQueue(self.videoQueue))
        if isDetecting {
            let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, options: [:])
            let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
            request.recognitionLevel = .accurate
            request.customWords = (0...9).map { String($0) }
            
            
            
            do {
                try requestHandler.perform([request])
            } catch {
                print("Unable to perform the request: \(error)")
            }
        }

    }
    
    private func recognizeTextHandler(request: VNRequest, error: Error?) {
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizedStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        onSuccess(recognizedStrings.reduce("") {
            return $0+$1
        })
        
    }
    
}
