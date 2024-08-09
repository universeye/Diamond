//
//  GeneralSettingsView.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/8.
//

import SwiftUI

struct GeneralSettingsView: View {
    @State private var settingOneValue = false
    @State private var settingTwoValue = false
    @State private var settingThreeValue = false

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.title2)
                    Text("Subtitle for the setting, explaining what it does")
                }
                Spacer()
                Toggle("", isOn: $settingOneValue)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Title 2")
                        .font(.title2)
                    Text("Subtitle for the setting, explaining what it does")
                }
                Spacer()
                Toggle("", isOn: $settingTwoValue)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Title 3")
                        .font(.title2)
                    Text("Subtitle for the setting, explaining what it does")
                }
                Spacer()
                Toggle("", isOn: $settingThreeValue)
            }
        }
    }
}

#Preview {
    GeneralSettingsView()
}
