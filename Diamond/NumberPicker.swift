//
//  NumberPicker.swift
//  Diamond
//
//  Created by Terry Kuo on 2024/8/23.
//

import SwiftUI

struct NumberPicker: View {
    @Binding var selectedNumber: Int
    let range: ClosedRange<Int> = 1...50
    
    var body: some View {
        Picker("Select a number", selection: $selectedNumber) {
            ForEach(range, id: \.self) { number in
                Text("\(number)")
            }
        }
        .labelsHidden()
    }
}
