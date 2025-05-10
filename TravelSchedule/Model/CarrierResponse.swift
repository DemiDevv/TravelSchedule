//
//  CarrierResponse.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 04.05.2025.
//


struct CarrierResponse: Codable, Sendable {
    let title: String?
    let email: String?
    let url: String?
    let contacts: String?
    let logo: String?
    let code: Int?
    let phone: String?
    let address: String?
    let codes: CarrierCodes?
    let offices: [String]?
}

struct CarrierCodes: Codable {
    let icao: String?
    let iata: String?
    let sirena: String?
}

