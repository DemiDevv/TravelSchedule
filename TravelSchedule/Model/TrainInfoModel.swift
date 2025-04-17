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
