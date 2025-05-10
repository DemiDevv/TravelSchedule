//
//  RouteInfoModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 22.04.2025.
//

import SwiftUI

struct RouteInfo: Hashable {
    let fromCity: City?
    let fromStation: Station?
    let toCity: City?
    let toStation: Station?
    
    // Реализация Hashable для использования в NavigationStack
    func hash(into hasher: inout Hasher) {
        hasher.combine(fromCity?.name)
        hasher.combine(fromStation?.name)
        hasher.combine(toCity?.name)
        hasher.combine(toStation?.name)
    }
    
    static func == (lhs: RouteInfo, rhs: RouteInfo) -> Bool {
        lhs.fromCity?.name == rhs.fromCity?.name &&
        lhs.fromStation?.name == rhs.fromStation?.name &&
        lhs.toCity?.name == rhs.toCity?.name &&
        lhs.toStation?.name == rhs.toStation?.name
    }
}
