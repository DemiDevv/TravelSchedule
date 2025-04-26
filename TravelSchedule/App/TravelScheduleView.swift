//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.03.2025.
//

import SwiftUI

struct TravelScheduleView: View {
    @AppStorage(Constants.isDarkMode.stringValue) var isDarkMode: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @State private var selectedTab = 0
    @State private var errorState: AppError? = nil
    @State private var isActive = true
    
    var body: some View {
        ZStack {
            if isActive {
                SplashView(isActive: $isActive)
            } else {
                if networkMonitor.isConnected {
                    NavigationStack {
                        MainTabView(selectedTab: $selectedTab, isDarkMode: isDarkMode)
                    }
                } else {
                    ErrorView(errors: AppError.noInternet)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TravelScheduleView()
}
