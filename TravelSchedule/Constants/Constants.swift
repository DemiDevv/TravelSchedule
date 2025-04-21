//
//  Constants.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.04.2025.
//

import Foundation

enum Constants {
    case isDarkMode
    
    var stringValue: String {
        switch self {
        case .isDarkMode: "isDarkMode"
        }
    }
}

extension Constants {
    static let spacing: CGFloat = 16
    static let inputFieldsHeight: CGFloat = 128
    static let inputFieldHeight: CGFloat = 24
    static let outerPadding: CGFloat = 16 // Новый константный отступ
    static let textFieldsPadding: CGFloat = 12
    static let fieldsSpacing: CGFloat = 16
    static let fontSize: CGFloat = 17
    static let cornerRadius: CGFloat = 16
    static let innerCornerRadius: CGFloat = 20
    static let swapButtonPadding: CGFloat = 12
}
