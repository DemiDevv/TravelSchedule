//
//  TravelScheduleFacade.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

final class TravelScheduleFacade {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // Сервисы
    private lazy var nearestStationsService: NearestStationsServiceProtocol = {
        NearestStationsService(client: client, apikey: apikey)
    }()
    
    private lazy var scheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol = {
        ScheduleBetweenStationsService(client: client, apikey: apikey)
    }()
    
    private lazy var scheduleOnStationService: ScheduleOnStationServiceProtocol = {
        ScheduleOnStationService(client: client, apikey: apikey)
    }()
    
    private lazy var threadStationsService: ThreadStationsServiceProtocol = {
        ThreadStationsService(client: client, apikey: apikey)
    }()
    
    private lazy var nearestSettlementService: NearestSettlementServiceProtocol = {
        NearestSettlementService(client: client, apikey: apikey)
    }()
    
    private lazy var carrierService: CarrierServiceProtocol = {
        CarrierService(client: client, apikey: apikey)
    }()
    
    private lazy var stationsListService: StationsListServiceProtocol = {
        StationsListService(client: client, apikey: apikey)
    }()
    
    private lazy var copyrightService: CopyrightServiceProtocol = {
        CopyrightService(client: client, apikey: apikey)
    }()
    
    // Методы фасада
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> Components.Schemas.Stations {
        try await nearestStationsService.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Components.Schemas.Search {
        try await scheduleBetweenStationsService.getScheduleBetweenStations(from: from, to: to, date: date)
    }
    
    func getScheduleOnStation(station: String, date: String?) async throws -> Components.Schemas.Schedule {
        try await scheduleOnStationService.getScheduleOnStation(station: station, date: date)
    }
    
    func getThreadStations(uid: String, date: String?) async throws -> Components.Schemas.Thread {
        try await threadStationsService.getThreadStations(uid: uid, date: date)
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int?) async throws -> Components.Schemas.Settlement {
        try await nearestSettlementService.getNearestSettlement(lat: lat, lng: lng, distance: distance)
    }
    
    func getCarrier(code: String, system: String?) async throws -> Components.Schemas.Carrier {
        try await carrierService.getCarrier(code: code, system: system)
    }
    
    func getStationsList() async throws -> Components.Schemas.StationsList {
        try await stationsListService.getStationsList()
    }
    
    func getCopyright() async throws -> Components.Schemas.Copyright {
        try await copyrightService.getCopyright()
    }
}

func exampleUsage() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let facade = TravelScheduleFacade(client: client, apikey: Secrets.apiKey)
            
            // Пример использования всех сервисов через фасад
            
            // 1. Получение ближайших станций
            let nearestStations = try await facade.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print("Nearest Stations: \(nearestStations)")
            
            // 2. Получение расписания между станциями
            let scheduleBetweenStations = try await facade.getScheduleBetweenStations(from: "s2000001", to: "s2000002", date: "2023-12-01")
            print("Schedule Between Stations: \(scheduleBetweenStations)")
            
            // 3. Получение расписания по станции
            let scheduleOnStation = try await facade.getScheduleOnStation(station: "s2000001", date: "2023-12-01")
            print("Schedule On Station: \(scheduleOnStation)")
            
            // 4. Получение списка станций следования для нитки
            let threadStations = try await facade.getThreadStations(uid: "12345", date: "2023-12-01")
            print("Thread Stations: \(threadStations)")
            
            // 5. Получение ближайшего населенного пункта
            let nearestSettlement = try await facade.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
            print("Nearest Settlement: \(nearestSettlement)")
            
            // 6. Получение информации о перевозчике
            let carrierInfo = try await facade.getCarrier(code: "SU", system: "iata")
            print("Carrier Info: \(carrierInfo)")
            
            // 7. Получение списка всех станций
            let stationsList = try await facade.getStationsList()
            print("Stations List: \(stationsList)")
            
            // 8. Получение информации о копирайте
            let copyrightInfo = try await facade.getCopyright()
            print("Copyright Info: \(copyrightInfo)")
            
        } catch {
            print("Error occurred: \(error)")
        }
    }
}
