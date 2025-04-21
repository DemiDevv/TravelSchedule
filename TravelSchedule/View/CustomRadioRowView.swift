//
//  CustomRadioRowView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 21.04.2025.
//

import SwiftUI

// MARK: - Custom Radio Row (60pt высота)
struct CustomRadioRow: View {
    let title: String
    let isSelected: Bool
    let isDarkMode: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .font(.title3)
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
