//
//  ScheduleOnStation.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol ScheduleOnStationServiceProtocol {
    func getScheduleOnStation(station: String, date: String?) async throws -> Components.Schemas.Schedule
}

final class ScheduleOnStationService: ScheduleOnStationServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleOnStation(station: String, date: String?) async throws -> Components.Schemas.Schedule {
        let response = try await client.getScheduleOnStation(query: .init(
            apikey: apikey,
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}
