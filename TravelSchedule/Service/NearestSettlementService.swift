//
//  NearestSettlement.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double, distance: Int?) async throws -> Components.Schemas.Settlement
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int?) async throws -> Components.Schemas.Settlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
