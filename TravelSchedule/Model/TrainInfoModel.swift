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
    let date: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
}
