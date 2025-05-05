//
//  RouteCarrier.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 06.05.2025.
//

import SwiftUI

struct RouteCarrier: Hashable, Identifiable {
    let id = UUID()
    let carrierImage: String
    let carrierName: String
    let transferInfo: Bool
    let routeDate: String
    let routeStartTime: String
    let routeEndTime: String
    let routeDuration: String
    let carrierCode: String
    let carrierMail: String
    let carrierPhone: String
}
