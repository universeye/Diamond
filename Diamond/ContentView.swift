//
//  ContentView.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/8.
//

import SwiftUI
import Combine
import KeyboardShortcuts

// Define a custom keyboard shortcut
extension KeyboardShortcuts.Name {
    static let generateRandomString = Self("generateRandomString")
}

struct PopoverView: View {
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image("Linearicons_diamond")
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                Text("Random String Generator")
                    .font(.headline)
            }
            Text("Set the keyboard shortcut")
                .font(.caption)
                .multilineTextAlignment(.center)
            
            KeyboardShortcuts.Recorder("Shortcut:", name: .generateRandomString)
            
            Divider()
                        
            HStack {
                Button(action: {
                    openWindow(id: "settings")
                }) {
                    Label("Settings", systemImage: "gear")
                }
                
                Spacer()
                
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Label("Quit", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .padding()
    }
}



#Preview {
    PopoverView()
}
