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
    @State private var errorState: SettingsErrorState = .none
    @State private var isActive = true // Состояние для экрана загрузки

    var body: some View {
        ZStack {
            if isActive {
                // Экран загрузки
                SplashScreen(isActive: $isActive)
            } else {
                // Основной контент
                NavigationView {
                    TabView(selection: $selectedTab) {
                        
                        // Первая вкладка — маршрут
                        RouteInputView()
                            .tabItem {
                                Image("schedule_image")
                                    .renderingMode(.template)
                                    .foregroundColor(selectedTab == 0 ? .black : .gray)
                            }
                            .tag(0)

                        // Вторая вкладка — настройки
                        SettingsView(errorState: $errorState)
                            .tabItem {
                                Image("settings_image")
                                    .renderingMode(.template)
                                    .foregroundColor(selectedTab == 1 ? .black : .gray)
                            }
                            .tag(1)
                    }
                    .tint(.black) // Устанавливаем основной цвет для активных элементов TabBar
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
