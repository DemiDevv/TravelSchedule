//
//  CustomCheckboxRowView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 21.04.2025.
//

import SwiftUI

// MARK: - Custom Checkbox Row (60pt высота)
struct CustomCheckboxRow: View {
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
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .font(.system(size: 24, weight: .medium))
            }
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//MARK: - Preview
#Preview {
    Group {
        CustomCheckboxRow(
            title: "Пример чекбокса",
            isSelected: true,
            isDarkMode: false,
            action: {}
        )
        .padding()
        
        CustomCheckboxRow(
            title: "Пример чекбокса (темная тема)",
            isSelected: false,
            isDarkMode: true,
            action: {}
        )
        .padding()
        .background(.blackYP)
    }
}
