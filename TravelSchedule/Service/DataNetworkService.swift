//
//  TravelScheduleService.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 16.04.2025.
//

import SwiftUI
import OpenAPIURLSession

struct DataNetworkService {
    @MainActor static let shared = DataNetworkService()
    
    private let client: Client
    private let service: TravelNetworkService
    
    init () {
        do {
            client = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
            service = TravelNetworkService(client: self.client, apikey: Secrets.apiKey)
        } catch {
            fatalError("Ошибка при создании сервиса загрузки данных: \(error.localizedDescription)")
        }
    }
    
    /// Метод вывода расписания рейсов между двумя остановками
    func scheduleBetweenStations(fromStationCode: String, toStationCode: String) async throws -> TwoStationSchedule {
        do {
            let schedule = try await service.GetScheduleBetweenStations(from: fromStationCode, to: toStationCode)
            return schedule
        } catch {
            print("Ошибка загрузки маршрутов между станциями: \(error.localizedDescription)")
            return TwoStationSchedule(segments: nil)
        }
    }
    
    /// Метод вывода списка рейсов проходящих через остановку
    private func stationSchedule() async throws {
        do {
            let _ = try await service.GetStationSchedule(station: "s9600213")
        } catch {
            print("Ошибка загрузки маршрутов станции: \(error.localizedDescription)")
        }
    }
    
    /// Метод вывода списка остановок на маршруте
    private func routeStations() async throws {
        do {
            let _ = try await service.GetRouteStations(uid: "028S_3_2")
        } catch {
            print("Ошибка загрузки остановок на маршруте: \(error.localizedDescription)")
        }
    }
    
    /// Метод вывода ближайшей остановки
    private func nearestStations() async throws {
        do  {
            let _ = try await service.GetNearestStations(lat: 55.813902, lng: 37.597299, distance: 5)
        } catch {
            print("Ошибка загрузки ближайшей остановки: \(error.localizedDescription)")
        }
    }
    
    /// Метод вывода ближайшего города
    private func nearestCity() async throws {
        do {
            let _ = try await service.GetNearestCity(lat: 55.813902, lng: 37.597299)
        } catch {
            print("Ошибка загрузки ближайшего города: \(error.localizedDescription)")
        }
    }
    
    /// Метод вывода информации о перевозчике
    func carrierInfo(code: String) async throws -> Carrier {
        do {
            let carrierInfo = try await service.GetCarrierInfo(code: code)
            let jsonData = try JSONSerialization.data(withJSONObject: carrierInfo.carrier?.value as? [String: Any], options: [])
            let decoder = JSONDecoder()
            let carrierResponse = try decoder.decode(CarrierResponseStruct.self, from: jsonData)
            let carrierList = Carrier(name: carrierResponse.title ?? "", logoURL: "RZD", email: carrierResponse.email ?? "", phone: carrierResponse.phone ?? "")
            return carrierList
        } catch {
            print("Ошика загрузки информации о перевозчике: \(error.localizedDescription)")
            return Carrier(name: "", logoURL: "", email: "", phone: "")
        }
    }
    
    /// Метод вывода всех доступных остановок
    func allStations() async throws -> [AllCitiesStruct] {
        do {
            let stations = try await service.GetAllStations()
            let rusArray = stations.countries?.filter { $0.title == "Россия" }
            return rusArray?.first?.regions?.flatMap { $0.settlements ?? [] } ?? []
        } catch {
            print("Ошибка загрузки станций: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Метод вывода копирайтов яндекса
    private func copyrights() async throws {
        do {
            let _ = try await service.GetCopyright()
        } catch {
            print("Ошибка загрузки копирайтов Яндекса: \(error.localizedDescription)")
        }
    }
}


