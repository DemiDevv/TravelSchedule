//
//  ListOfCarriersViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 04.05.2025.
//

//
//  CarriersViewModel.swift
//  TravelSchedule
//

import SwiftUI

@MainActor
final class ListOfCarriersViewModel: ObservableObject {
    @Published var carriers: [RouteCarrierStruct] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let isoFormatter = ISO8601DateFormatter()
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    func loadCarriers(fromStationCode: String, toStationCode: String) async {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        do {
            let schedule = try await DataNetworkService.shared.scheduleBetweenStations(fromStationCode: fromStationCode, toStationCode: toStationCode)
            
            guard let segments = schedule.segments else {
                carriers = []
                return
            }
            
            carriers = segments.compactMap { segment in
                guard let thread = segment.thread,
                      let carrier = thread.carrier else {
                    return nil
                }
                
                let startTime = isoFormatter.date(from: segment.departure ?? "")
                let stopTime = isoFormatter.date(from: segment.arrival ?? "")
                
                let startFormatted = startTime.map { timeFormatter.string(from: $0) } ?? "N/A"
                let stopFormatted = stopTime.map { timeFormatter.string(from: $0) } ?? "N/A"
                let routeDay = startTime.map { dateFormatter.string(from: $0) } ?? "N/A"
                
                return RouteCarrierStruct(
                    carrierImage: carrier.logo ?? "",
                    carrierName: carrier.title ?? "Неизвестный перевозчик",
                    transferInfo: segment.has_transfers ?? false,
                    routeDate: routeDay,
                    routeStartTime: startFormatted,
                    routeEndTime: stopFormatted,
                    routeDuration: String(format: "%.f часов", Double(segment.duration ?? 0) / 3600),
                    carrierCode: String(carrier.code ?? 0),
                    carrierMail: carrier.email ?? "Электронная почта отсутствует",
                    carrierPhone: carrier.phone ?? "Номер телефона отсутствует"
                )
            }
        } catch {
            self.error = error
            print("Ошибка загрузки: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
