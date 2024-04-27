//
//  ContentView.swift
//  CameraTest
//
//  Created by Gokul Murugan on 19/02/24.
//

import SwiftUI

struct ContentView: View{
    @StateObject private var cameraFeedManager = CameraFeedManager(previewView: PreviewView())    
    var body: some View {
        VStack {
            CameraPresentationView(session: cameraFeedManager.session, delegate: cameraFeedManager as? CameraFeedManagerDelegate)
                .onAppear {
                    cameraFeedManager.delegate = cameraFeedManager as? any CameraFeedManagerDelegate
                    cameraFeedManager.checkCameraConfigurationAndStartSession()
                }
                .onDisappear {
                    cameraFeedManager.stopSession()
                }
        }
    }
}


#Preview {
    ContentView()
}
