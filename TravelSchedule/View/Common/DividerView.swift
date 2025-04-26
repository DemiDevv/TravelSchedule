//
//  DividerView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 20.04.2025.
//

import SwiftUI

struct DividerView: View {
    let isDarkMode: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(isDarkMode ? Color.black : Color.gray.opacity(0.3))
                .frame(height: 0.5)
                .padding(.bottom, 58)
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Preview
struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView(isDarkMode: false)
    }
}
