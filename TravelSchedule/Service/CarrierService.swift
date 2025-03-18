//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol CarrierServiceProtocol {
    func getCarrier(code: String, system: String?) async throws -> Components.Schemas.Carrier
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrier(code: String, system: String?) async throws -> Components.Schemas.Carrier {
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
