//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(Constants.isDarkMode.stringValue) var isDarkMode: Bool = false
    
    @State private var selectedTab = 0
    @State private var errorState: AppError? = nil
    @State private var isActive = true // Состояние для экрана загрузки

    var body: some View {
        ZStack {
            if isActive {
                // Экран загрузки
                SplashScreen(isActive: $isActive)
            } else {
                // Основной контент
                NavigationView {
                    ZStack(alignment: .bottom) {
                        TabView(selection: $selectedTab) {
                            // Первая вкладка — маршрут
                            RouteInputView()
                                .tabItem {
                                    Image("schedule_image")
                                        .renderingMode(.template)
                                        .foregroundColor(selectedTab == 0 ? (isDarkMode ? .white : .blackYP) : .grayYP)
                                }
                                .tag(0)

                            // Вторая вкладка — настройки
                            SettingsView(errorState: $errorState)
                                .tabItem {
                                    Image("settings_image")
                                        .renderingMode(.template)
                                        .foregroundColor(selectedTab == 1 ? (isDarkMode ? .white : .blackYP) : .grayYP)
                                }
                                .tag(1)
                        }
                        .tint(isDarkMode ? .white : .blackYP)
                        .onChange(of: errorState) { newValue in
                            if newValue != nil {
                                print("Произошла ошибка: \(newValue!)")
                            }
                        }

                        // 🔽 Тонкая линия над TabBar с отступом 10
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(isDarkMode ? Color.black : Color.gray.opacity(0.3))
                                .frame(height: 0.5)
                                .padding(.bottom, 58) // 48 — высота TabBar + 10 отступ
                        }
                        .allowsHitTesting(false)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
