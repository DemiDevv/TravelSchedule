//
//  RowView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RowView: View {
    let title: String
    let isDarkMode: Bool
    var showChevron: Bool = true
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if showChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .font(.system(size: 20, weight: .medium))
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .background(isDarkMode ? Color.blackYP : Color.white)
    }
}

// MARK: - Preview
#Preview {
    RowView(title: "Москва", isDarkMode: false, showChevron: true)
}
