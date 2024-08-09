//
//  DiamondApp.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/8.
//

import SwiftUI
import KeyboardShortcuts


@main
struct RandomStringGeneratorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GeneralSettingsView()
        }
        .defaultSize(CGSize(width: 450, height: 350))
        
        Window("Settings", id: "settings") {
            GeneralSettingsView()
        }
        .defaultSize(CGSize(width: 450, height: 350))
        
        Settings {
            TabView {
                GeneralSettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
            
        }
    }
}
