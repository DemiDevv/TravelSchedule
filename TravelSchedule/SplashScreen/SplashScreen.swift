//
//  SplashScreen.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.04.2025.
//

import SwiftUI

// MARK: - SplashScreen

struct SplashScreen: View {
    // MARK: - Properties

    @Binding var isActive: Bool
    private let splashDuration: TimeInterval = 3

    // MARK: - Body

    var body: some View {
        splashBackground
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {
                    withAnimation {
                        isActive = false
                    }
                }
            }
    }

    // MARK: - Subviews

    private var splashBackground: some View {
        Image("splash_screen")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .ignoresSafeArea()
    }
}


// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @State private var isActive = true

        var body: some View {
            SplashScreen(isActive: $isActive)
        }
    }

    return PreviewWrapper()
}
