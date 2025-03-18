//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Components.Schemas.Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright() async throws -> Components.Schemas.Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}

