//
//  ChoiceCityView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 05.04.2025.
//

import SwiftUI

struct ChoiceCityView: View {
    @Binding var selected: CityStation
    @Environment(\.presentationMode) var presentationMode
    
    let cities = ["Москва", "Санкт-Петербург", "Сочи"]
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Кастомная поисковая строка
            SearchBar(text: $searchText, isSearching: $isSearching)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
            
            // Основное содержимое
            if filteredCities.isEmpty && !searchText.isEmpty {
                // Сообщение, если ничего не найдено
                VStack {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.blackYP)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                // Список городов
                List {
                    ForEach(filteredCities, id: \.self) { city in
                        NavigationLink(destination: ChoiceStationView(city: city, selected: $selected)) {
                            RowView(title: city)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color.white)
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
        .onChange(of: searchText) { _ in
            isSearching = !searchText.isEmpty
        }
    }
    
    var filteredCities: [String] {
        searchText.isEmpty ? cities : cities.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
}

struct ChoiceCityView_Previews: PreviewProvider {
    @State static var selected = CityStation(city: "Откуда", station: nil)

    static var previews: some View {
        NavigationView {
            ChoiceCityView(selected: $selected)
        }
    }
}
