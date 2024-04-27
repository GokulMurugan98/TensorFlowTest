//
//  PreviewView.swift
//  CameraTest
//
//  Created by Gokul Murugan on 19/02/24.
//
import UIKit
import AVFoundation

class PreviewView: UIView {
    private let clipboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var isUsingClipboardImage: Bool = false {
        didSet {
            if isUsingClipboardImage {
                addSubview(clipboardImageView)
                // ... (constraints)
            } else {
                clipboardImageView.removeFromSuperview()
            }
        }
    }

    var image: UIImage? {
        get {
            return clipboardImageView.image
        }
        set {
            clipboardImageView.image = newValue
        }
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Layer expected is of type VideoPreviewLayer")
        }
        return layer
    }

    var session: AVCaptureSession? {
        get {
            return previewLayer.session
        }
        set {
            previewLayer.session = newValue
        }
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}

