//
//  GeneralSettingsView.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/8.
//

import SwiftUI
import KeyboardShortcuts

struct GeneralSettingsView: View {
    @State private var isShowWelcome = false
    @AppStorage("selectedNumber") var selectedNumber: Int = 10
    
    var body: some View {
        Form {
            HStack {
                Text("Welcom to Diamond!")
                Image("Linearicons_diamond")
                    .renderingMode(.template)
                    .foregroundStyle(.white)
            }
            .bold()
            .frame(maxWidth: .infinity)
            .opacity(isShowWelcome ? 1 : 0)
            
            Section {
                KeyboardShortcuts.Recorder("Generate Random String Shortcut:", name: .generateRandomString)
                
                HStack {
                    Text("Number of String:")
                    Spacer()
                    NumberPicker(selectedNumber: $selectedNumber)
                }
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
        }
        .formStyle(.grouped)
        .frame(minWidth: 450, minHeight: 200)
        .navigationTitle("Diamond")
        .onAppear {
            withAnimation {
                isShowWelcome.toggle()
            }
        }
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


