//
//  CarrierModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct Carrier: Identifiable {
    let id: UUID = UUID()
    let name: String
    let logoURL: URL?
    let email: String
    let phone: String
}

