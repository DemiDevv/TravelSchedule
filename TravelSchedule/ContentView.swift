//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(Constants.isDarkMode.stringValue) var isDarkMode: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @State private var selectedTab = 0
    @State private var errorState: AppError? = nil
    @State private var isActive = true // Состояние для экрана загрузки

    var body: some View {
        ZStack {
            if isActive {
                // Экран загрузки
                SplashScreen(isActive: $isActive)
            } else {
                // Основной контент или экран ошибки
                if networkMonitor.isConnected {
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
                } else {
                    // Показываем экран ошибки при отсутствии интернета
                    ErrorView(errors: AppError.noInternet)
                        .transition(.opacity)
                }
            }
        }
        .animation(.default, value: networkMonitor.isConnected)
    }
}

// Network Monitor
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
