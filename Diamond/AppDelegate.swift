//
//  AppDelegate.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/9.
//

import SwiftUI
import Combine
import KeyboardShortcuts

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    private let userdefaults = UserDefaults.standard
    
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
        if let number = userdefaults.object(forKey: "selectedNumber") as? Int {
            return String((0..<number).map{ _ in letters.randomElement()! })
        } else {
            return String((0..<10).map{ _ in letters.randomElement()! })
        }
    }
}
