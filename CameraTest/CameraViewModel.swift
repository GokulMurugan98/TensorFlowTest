//
//  CameraViewModel.swift
//  CameraTest
//
//  Created by Gokul Murugan on 19/02/24.
//

import Foundation
import AVFoundation

class CameraViewModel:CameraFeedManagerDelegate{
    func sessionRunTimeErrorOccurred() {
        print("Session Run Time error")
    }
    
    
    private var imageClassificationHelper: ImageClassificationHelper? = ImageClassificationHelper(
        modelFileInfo: DefaultConstants.model.modelFileInfo, // Provide correct model file info
        threadCount: DefaultConstants.threadCount,
        resultCount: DefaultConstants.maxResults,
        scoreThreshold: DefaultConstants.scoreThreshold
    )
    
    private var previousInferenceTimeMs = Date.distantPast.timeIntervalSince1970 * 1000
    private let delayBetweenInferencesMs = 1000.0
    private var isInferenceQueueBusy = false
    
    func presentCameraPermissionsDeniedAlert() {
        print("Camera Permission Denied")
    }
    
    func presentVideoConfigurationErrorAlert() {
        print("Video Confiuration Error")
    }
    
    func sessionRunTimeErrorOccured() {
        print("Session Runtime Error")
    }
    
    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {
        print("Sesion was interupted")
    }
    
    func sessionInterruptionEnded() {
        print("Session Intereuption Ended")
    }
    
    func setDelegate(){
        
        
    }
    
    func didOutput(pixelBuffer: CVPixelBuffer) {
           let result = self.imageClassificationHelper?.classify(frame: pixelBuffer)
           print(result)
       }
}

enum DefaultConstants {
    static let threadCount = 4
    static let maxResults = 3
    static let scoreThreshold: Float = 0.2
    static let model: ModelType = .efficientnetLite0
}

/// TFLite model types
enum ModelType: CaseIterable {
    case efficientnetLite0
    case efficientnetLite1
    case efficientnetLite2
    case efficientnetLite3
    case efficientnetLite4
    
    var modelFileInfo: FileInfo {
        switch self {
        case .efficientnetLite0:
            return FileInfo("efficientnet_lite0", "tflite")
        case .efficientnetLite1:
            return FileInfo("efficientnet_lite1", "tflite")
        case .efficientnetLite2:
            return FileInfo("efficientnet_lite2", "tflite")
        case .efficientnetLite3:
            return FileInfo("efficientnet_lite3", "tflite")
        case .efficientnetLite4:
            return FileInfo("efficientnet_lite4", "tflite")
        }
    }
    
    var title: String {
        switch self {
        case .efficientnetLite0:
            return "EfficientNet-Lite0"
        case .efficientnetLite1:
            return "EfficientNet-Lite1"
        case .efficientnetLite2:
            return "EfficientNet-Lite2"
        case .efficientnetLite3:
            return "EfficientNet-Lite3"
        case .efficientnetLite4:
            return "EfficientNet-Lite4"
        }
    }
}
