//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var errorState: SettingsErrorState = .none
    @Published var isDarkMode = false
    @Published var showingUserAgreement = false
    @Published var tabBarIsHidden = false
    
    func toggleDarkMode() {
        // Здесь может быть дополнительная логика для смены темы
        isDarkMode.toggle()
    }
    
    func showUserAgreement() {
        tabBarIsHidden = true
        showingUserAgreement = true
    }
    
    func errorImageName() -> String {
        switch errorState {
        case .noInternet: return "no_internet"
        case .serverError: return "server_error"
        case .none: return ""
        }
    }
    
    func errorText() -> String {
        switch errorState {
        case .noInternet: return "Нет интернета"
        case .serverError: return "Ошибка сервера"
        case .none: return ""
        }
    }
}
