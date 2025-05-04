//
//  TrainInfoModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct TrainInfo: Identifiable {
    let id = UUID()
    let companyName: String
    let companyLogo: Image
    let note: String?
    let date: Date
    let departureTime: Date
    let arrivalTime: Date
    let duration: TimeInterval
}

struct RouteCarrierStruct: Hashable, Identifiable {
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
