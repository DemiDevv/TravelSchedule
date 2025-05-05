//
//  TravelScheduleFacade.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias NearestStations = Components.Schemas.Stations
typealias TwoStationSchedule = Components.Schemas.Segments
typealias OneStationSchedule = Components.Schemas.ScheduleResponse
typealias StationsOnTheRoute = Components.Schemas.ThreadStationsResponse
typealias NearestSettlementInfo = Components.Schemas.NearestCityResponse
typealias CarrierInfo = Components.Schemas.CarrierResponse
typealias StationInfo = Components.Schemas.AllStationsResponse
typealias CopyrightInfo = Components.Schemas.CopyrightResponse
typealias AllCitiesStruct = Components.Schemas.Settlement
typealias AllStationStruct = Components.Schemas.Station

protocol TravelNetworkServiceProtocol {
    func GetNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func GetScheduleBetweenStations(from: String, to: String) async throws -> TwoStationSchedule
    func GetStationSchedule(station: String) async throws -> OneStationSchedule
    func GetRouteStations(uid: String) async throws -> StationsOnTheRoute
    func GetNearestCity(lat: Double, lng: Double) async throws -> NearestSettlementInfo
    func GetCarrierInfo(code: String) async throws -> CarrierInfo
    func GetAllStations() async throws -> StationInfo
    func GetCopyright() async throws -> CopyrightInfo
}

final class TravelNetworkService: TravelNetworkServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: Расписание рейсов между станциями
    func GetScheduleBetweenStations(from: String, to: String) async throws -> TwoStationSchedule {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())

        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: dateString,
            transfers: true
        ))
        return try response.ok.body.json
    }
    
    // MARK: Список рейсов у станции
    func GetStationSchedule(station: String) async throws -> OneStationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: "2025-01-22"
        ))
        return try response.ok.body.json
    }
    
    // MARK: Список станций на маршруте
    func GetRouteStations(uid: String) async throws -> StationsOnTheRoute {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        print(try response.ok.body.json)
        return try response.ok.body.json
    }
    
    // MARK: Список ближайших станций
    func GetNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
    
    // MARK: Ближайший город по координатам
    func GetNearestCity(lat: Double, lng: Double) async throws -> NearestSettlementInfo {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
        ))
        return try response.ok.body.json
    }
    
    // MARK: Информация о перевозчике
    func GetCarrierInfo(code: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
    
    // MARK: Информация о всех станциях
    func GetAllStations() async throws -> StationInfo {
        var data = Data()
        
        do {
            let response = try await client.getAllStations(query: .init(apikey: apikey))
            
            for try await chunk in try response.ok.body.text_html_charset_utf_hyphen_8 {
                data.append(contentsOf: chunk)
            }
            
            let decoder = JSONDecoder()
            let stationInfo = try decoder.decode(StationInfo.self, from: data)
            return stationInfo
        } catch {
            print("Запрос выдал ошибку: \(error)")
            throw error
        }
    }
    
    // MARK:  Копирайт Яндекс Расписаний
    func GetCopyright() async throws -> CopyrightInfo {
        let response = try await client.getCopyright(query: .init(apikey: apikey))
        return try response.ok.body.json
    }
}

