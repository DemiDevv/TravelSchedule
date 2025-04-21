//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.03.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            TravelScheduleView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .animation(.easeOut, value: isDarkMode)
        }
    }
}
