//
//  GetScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Search = Components.Schemas.Search

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Search
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Search {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}

