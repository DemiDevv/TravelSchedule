//
//  TabItemView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 20.04.2025.
//

import SwiftUI

struct TabItemView: View {
    let imageName: String
    let isSelected: Bool
    let isDarkMode: Bool
    
    var body: some View {
        Image(imageName)
            .renderingMode(.template)
            .foregroundColor(isSelected ? (isDarkMode ? .white : .blackYP) : .grayYP)
    }
}

// MARK: - Preview
struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(
            imageName: "schedule_image",
            isSelected: true,
            isDarkMode: false
        )
    }
}
