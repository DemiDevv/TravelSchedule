//
//  CityStationModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct CityStation: Equatable {
    var city: String
    var station: String?
    
    var displayName: String {
        if let station = station {
            return "\(city) (\(station))"
        }
        return city
    }
}

