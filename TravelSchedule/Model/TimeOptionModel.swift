//
//  TimeOption.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 21.04.2025.
//

import SwiftUI

// MARK: - Модель времени
enum TimeOption: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    
    var label: String {
        self.rawValue
    }
}
