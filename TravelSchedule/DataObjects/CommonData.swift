//
//  CommonData.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 04.05.2025.
//

import SwiftUI

@MainActor
final class CommonData: ObservableObject {
    static let shared = CommonData()
    
    @Published var commonCities: [City] = []
}
