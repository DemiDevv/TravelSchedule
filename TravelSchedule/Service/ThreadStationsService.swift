//
//  ThreadStations.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol ThreadStationsServiceProtocol {
    func getThreadStations(uid: String, date: String?) async throws -> Components.Schemas.Thread
}

final class ThreadStationsService: ThreadStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreadStations(uid: String, date: String?) async throws -> Components.Schemas.Thread {
        let response = try await client.getThreadStations(query: .init(
            apikey: apikey,
            uid: uid,
            date: date
        ))
        return try response.ok.body.json
    }
}
