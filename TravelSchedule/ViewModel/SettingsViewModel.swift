//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    @Published var errorState: AppError? = nil
    @Published var showingUserAgreement = false
    @Published var tabBarIsHidden = false
    
    func toggleDarkMode(isDarkMode: Bool) {
        // Здесь может быть дополнительная логика для смены темы
    }
    
    func showUserAgreement() {
        tabBarIsHidden = true
        showingUserAgreement = true
    }
}
