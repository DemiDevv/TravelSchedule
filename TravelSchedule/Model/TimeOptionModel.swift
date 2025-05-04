//
//  TimeOption.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 21.04.2025.
//

import SwiftUI

// MARK: - Модель времени
enum TimeOption: String, CaseIterable, Hashable {
    case morning, afternoon, evening, night
    
    var label: String {
        switch self {
        case .morning: return "Утро 06:00 - 12:00"
        case .afternoon: return "День 12:00 - 18:00"
        case .evening: return "Вечер 18:00 - 00:00"
        case .night: return "Ночь 00:00 - 06:00"
        }
    }
    
    func contains(hour: Int) -> Bool {
        switch self {
        case .morning: return (6..<12).contains(hour)
        case .afternoon: return (12..<18).contains(hour)
        case .evening: return (18..<24).contains(hour)
        case .night: return (0..<6).contains(hour)
        }
    }
}
