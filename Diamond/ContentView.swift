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

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "textformat.abc", accessibilityDescription: "Random String Generator")
        }
        
        // Set up the default keyboard shortcut
        KeyboardShortcuts.setShortcut(.init(.period, modifiers: .command), for: .generateRandomString)
        
        // Listen for the keyboard shortcut
        KeyboardShortcuts.onKeyDown(for: .generateRandomString) { [weak self] in
            self?.generateAndPasteRandomString()
        }
        
        // Create and configure the popover
        popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 100)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: PopoverView())
        
        // Add click action to the status bar item
        statusBarItem.button?.action = #selector(togglePopover(_:))
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func generateAndPasteRandomString() {
        let randomString = generateRandomString()
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(randomString, forType: .string)
        
        // Simulate Cmd+V to paste the string
        let source = CGEventSource(stateID: .hidSystemState)
        let cmdDown = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: true)
        let vDown = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
        let vUp = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
        let cmdUp = CGEvent(keyboardEventSource: source, virtualKey: 0x37, keyDown: false)
        
        cmdDown?.flags = .maskCommand
        vDown?.flags = .maskCommand
        vUp?.flags = .maskCommand
        
        let loc = CGEventTapLocation.cghidEventTap
        cmdDown?.post(tap: loc)
        vDown?.post(tap: loc)
        vUp?.post(tap: loc)
        cmdUp?.post(tap: loc)
    }
    
    func generateRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<10).map{ _ in letters.randomElement()! })
    }
}

struct PopoverView: View {
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Random String Generator")
                .font(.headline)
                .padding(.top)
            Text("Press the keyboard shortcut")
                .font(.caption)
                .multilineTextAlignment(.center)
            KeyboardShortcuts.Recorder("Shortcut:", name: .generateRandomString)
            
            Divider()
                        
            HStack {
                Button(action: {
                    openWindow(id: "whats-new")
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
            .padding(.bottom)
        }
        .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        Form {
            KeyboardShortcuts.Recorder("Generate Random String:", name: .generateRandomString)
        }
        .padding()
        .frame(width: 300, height: 100)
    }
}

