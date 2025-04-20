//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//
import SwiftUI

struct RouteInputView: View {
    @State private var fromCity: City?
    @State private var fromStation: Station?
    @State private var toCity: City?
    @State private var toStation: Station?
    @State private var navigationPath = NavigationPath()
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    private func displayText(isFromField: Bool) -> String {
        let city = isFromField ? fromCity : toCity
        let station = isFromField ? fromStation : toStation
        
        guard let city = city else { return isFromField ? "Откуда" : "Куда" }
        guard let station = station else { return city.name }
        return "\(city.name) (\(station.name))"
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 16) { // Изменено на 16pt между элементами
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.blueYP)
                        .frame(height: 130)
                    
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            // Поле "Откуда"
                            Button(action: {
                                navigationPath.append(Destination.choiceCity(fromField: true))
                            }) {
                                Text(displayText(isFromField: true))
                                    .foregroundColor(fromCity == nil ? .gray : .black) // Всегда черный для выбранного
                                    .font(.system(size: 17))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // Поле "Куда"
                            Button(action: {
                                navigationPath.append(Destination.choiceCity(fromField: false))
                            }) {
                                Text(displayText(isFromField: false))
                                    .foregroundColor(toCity == nil ? .gray : .black) // Всегда черный для выбранного
                                    .font(.system(size: 17))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        
                        Button(action: {
                            withAnimation {
                                swap(&fromCity, &toCity)
                                swap(&fromStation, &toStation)
                            }
                        }) {
                            Image("switch_arrow")
                                .foregroundColor(.blueYP)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)
                    }
                }
                .padding(.top, 16)
                
                if isSearchEnabled {
                    Button(action: {
                        print("Откуда: \(fromCity?.name ?? "") (\(fromStation?.name ?? ""))")
                        print("Куда: \(toCity?.name ?? "") (\(toStation?.name ?? ""))")
                    }) {
                        Text("Найти")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 150, height: 60)
                            .background(Color.blueYP)
                            .cornerRadius(16)
                    }
                    .padding(.bottom, 16) // Отступ снизу 16pt
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .background(isDarkMode ? Color.blackYP : Color.white)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .choiceCity(let isFromField):
                    ChoiceCityView(
                        isFromField: isFromField,
                        selectedCity: isFromField ? $fromCity : $toCity,
                        selectedStation: isFromField ? $fromStation : $toStation,
                        navigationPath: $navigationPath
                    )
                    .ignoresSafeArea(edges: .bottom) // Перекрывает TabBar
                case .choiceStation(let city, let isFromField):
                    ChoiceStationView(
                        city: city,
                        isFromField: isFromField,
                        selectedStation: isFromField ? $fromStation : $toStation,
                        navigationPath: $navigationPath
                    )
                    .ignoresSafeArea(edges: .bottom) // Перекрывает TabBar
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct RouteInputFields: View {
    @Binding var fromCity: City?
    @Binding var fromStation: Station?
    @Binding var toCity: City?
    @Binding var toStation: Station?
    @Binding var navigationPath: NavigationPath
    let isDarkMode: Bool
    
    private func displayText(isFromField: Bool) -> String {
        let city = isFromField ? fromCity : toCity
        let station = isFromField ? fromStation : toStation
        
        if let city = city, let station = station {
            return "\(city.name) (\(station.name))"
        } else if let city = city {
            return city.name
        }
        return isFromField ? "Откуда" : "Куда"
    }
    
    private func textColor(isFromField: Bool) -> Color {
        let city = isFromField ? fromCity : toCity
        return city == nil ? .gray : (isDarkMode ? .whiteYP : .blackYP)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blueYP)
                .frame(height: 130)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    inputField(isFromField: true)
                    inputField(isFromField: false)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
                swapButton
            }
        }
    }
    
    private func inputField(isFromField: Bool) -> some View {
        Button(action: {
            navigationPath.append(Destination.choiceCity(fromField: isFromField))
        }) {
            HStack {
                Text(displayText(isFromField: isFromField))
                    .foregroundColor(textColor(isFromField: isFromField))
                    .font(.system(size: 17))
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var swapButton: some View {
        Button(action: {
            withAnimation {
                swap(&fromCity, &toCity)
                swap(&fromStation, &toStation)
            }
        }) {
            Image("switch_arrow")
                .foregroundColor(.blueYP)
                .padding(12)
                .background(Color.white)
                .clipShape(Circle())
        }
        .padding(.trailing, 10)
    }
}
