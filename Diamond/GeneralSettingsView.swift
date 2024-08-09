//
//  GeneralSettingsView.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/8.
//

import SwiftUI
import KeyboardShortcuts

struct GeneralSettingsView: View {
    @State private var settingOneValue = false
    @State private var settingTwoValue = false
    @State private var settingThreeValue = false
    
    var body: some View {
        Form {
            Section {
                KeyboardShortcuts.Recorder("Generate Random String Shortcut:", name: .generateRandomString)
            } footer: {
                VStack {
                    Image("Group 55")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                    Text("\(NSLocalizedString("Version", comment: "Version")) \(getAppVersion())(\(getBuildNumber()))")
                    Text("© 2024 Universeye")
                }
                .frame(maxWidth: .infinity)
            }
            
            //            Section {
            //                Toggle(isOn: $settingTwoValue, label: {
            //                    VStack(alignment: .leading) {
            //                        Text("Launch at login")
            //                            .font(.title2)
            //
            //                    }
            //                })
            //
            //                Toggle(isOn: $settingThreeValue, label: {
            //                    VStack(alignment: .leading) {
            //                        Text("Check for updates")
            //                            .font(.title2)
            //                        Text("Subtitle for the setting, explaining what it does")
            //                    }
            //                })
            //            } header: {
            //                Text("Section two")
            //            } footer: {
            //                VStack {
            //                    Image("Group 55")
            //                        .resizable()
            //                        .scaledToFill()
            //                        .frame(width: 40, height: 40)
            //                    Text("\(NSLocalizedString("Version", comment: "Version")) (\(Bundle.main.releaseAndBuildNumberDouble))")
            //                    Text("© 2024 Universeye")
            //                }
            //                .frame(maxWidth: .infinity)
            //            }
        }
        .formStyle(.grouped)
        .frame(minWidth: 450, minHeight: 100)
    }
    
    private func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
    
    private func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "Unknown"
    }
}

#Preview {
    GeneralSettingsView()
}
