//
//  CityModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let stations: [Station]
}
