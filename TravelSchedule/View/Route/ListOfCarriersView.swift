//
//  ListOfCarriersView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct ListOfCarriersView: View {
    let routeInfo: RouteInfo
    @StateObject private var viewModel = ListOfCarriersViewModel()
    
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    @State private var showingDepartureTimeView = false
    @Environment(\.dismiss) private var dismiss
    
    private var routeTitle: String {
        let fromText = "(\(routeInfo.fromStation?.name ?? ""))"
        let toText = "(\(routeInfo.toStation?.name ?? ""))"
        return "\(fromText) → \(toText)"
    }
    
    var body: some View {
        contentView
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showingDepartureTimeView) {
                DepartureTimeView()
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.system(size: 22, weight: .medium))
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadCarriers(
                        fromStationCode: routeInfo.fromStation?.code ?? "",
                        toStationCode: routeInfo.toStation?.code ?? ""
                    )
                }
            }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(routeTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(isDarkMode ? .whiteYP : .black)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 50)
            } else if viewModel.carriers.isEmpty {
                Spacer()
                Text(viewModel.error == nil ? "Вариантов нет" : "Ошибка загрузки")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .black)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.carriers) { carrier in
                            NavigationLink(destination: CarriersCardView(carrier: Carrier(
                                name: carrier.carrierName,
                                logoURL: carrier.carrierImage,
                                email: carrier.carrierMail,
                                phone: carrier.carrierPhone
                            ))) {
                                TrainCellView(train: convertToTrainInfo(carrier: carrier))
                            }
                        }
                    }
                }
            }

            Button(action: { showingDepartureTimeView = true }) {
                Text("Уточнить время")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 60)
            .background(Color.blueYP)
            .cornerRadius(16)
            .padding(.top, 8)
        }
        .padding(16)
        .background(isDarkMode ? Color.blackYP : Color.white)
    }
    
    private func convertToTrainInfo(carrier: RouteCarrierStruct) -> TrainInfo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        // Создаем базовую дату для демонстрации
        let baseDate = Date()
        
        // Парсим время отправления
        let departureComponents = carrier.routeStartTime.components(separatedBy: ":")
        let departureHour = Int(departureComponents.first ?? "0") ?? 0
        let departureMinute = Int(departureComponents.last ?? "0") ?? 0
        
        // Парсим продолжительность (предполагаем формат "X часов")
        let durationHours = Int(carrier.routeDuration.components(separatedBy: " ").first ?? "0") ?? 0
        
        // Создаем даты
        let departureDate = Calendar.current.date(
            bySettingHour: departureHour,
            minute: departureMinute,
            second: 0,
            of: baseDate
        ) ?? baseDate
        
        let arrivalDate = Calendar.current.date(
            byAdding: .hour,
            value: durationHours,
            to: departureDate
        ) ?? baseDate
        
        return TrainInfo(
            companyName: carrier.carrierName,
            companyLogo: Image(systemName: "tram.fill"), // или загружаем из carrier.carrierImage
            note: carrier.transferInfo ? "С пересадкой" : nil,
            date: baseDate,
            departureTime: departureDate,
            arrivalTime: arrivalDate,
            duration: TimeInterval(durationHours * 3600)
        )
    }
}
