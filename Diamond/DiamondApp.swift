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
        Settings {
            SettingsView()
        }
    }
}
