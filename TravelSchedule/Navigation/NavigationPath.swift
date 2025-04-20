//
//  NavigationPath.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 19.04.2025.
//

import SwiftUI

enum Destination: Hashable {
    case choiceCity(fromField: Bool)
    case choiceStation(city: City, isFromField: Bool)
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case (.choiceCity(let lhsFrom), .choiceCity(let rhsFrom)):
            return lhsFrom == rhsFrom
        case (.choiceStation(let lhsCity, let lhsFrom), .choiceStation(let rhsCity, let rhsFrom)):
            return lhsCity.id == rhsCity.id && lhsFrom == rhsFrom
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .choiceCity(let fromField):
            hasher.combine("choiceCity")
            hasher.combine(fromField)
        case .choiceStation(let city, let fromField):
            hasher.combine("choiceStation")
            hasher.combine(city.id)
            hasher.combine(fromField)
        }
    }
}
