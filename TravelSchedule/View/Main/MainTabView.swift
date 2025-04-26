//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 20.04.2025.
//

import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: Int
    let isDarkMode: Bool
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RouteInputView()
                .tabItem {
                    TabItemView(
                        imageName: "schedule_image",
                        isSelected: selectedTab == 0,
                        isDarkMode: isDarkMode
                    )
                }
                .tag(0)
            
            SettingsView(errorState: .constant(nil))
                .tabItem {
                    TabItemView(
                        imageName: "settings_image",
                        isSelected: selectedTab == 1,
                        isDarkMode: isDarkMode
                    )
                }
                .tag(1)
        }
        .tint(isDarkMode ? .white : .blackYP)
        .overlay(
            DividerView(isDarkMode: isDarkMode),
            alignment: .bottom
        )
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedTab: .constant(0), isDarkMode: false)
    }
}
