//
//  CameraPresentationView.swift
//  CameraTest
//
//  Created by Gokul Murugan on 19/02/24.
//
import SwiftUI
import AVFoundation

struct CameraPresentationView: UIViewRepresentable {
    var session: AVCaptureSession?
    weak var delegate: CameraFeedManagerDelegate?

    func makeUIView(context: Context) -> PreviewView {
        let preview = PreviewView()
        preview.session = session
        return preview
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        uiView.session = session
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        delegate?.didOutput(pixelBuffer: pixelBuffer)
    }
    
    typealias UIViewType = PreviewView
}

