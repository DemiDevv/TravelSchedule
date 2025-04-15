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
    @StateObject private var viewModel = ChoiceCityViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Кастомная поисковая строка
            SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
            
            // Основное содержимое
            if viewModel.filteredCities.isEmpty && !viewModel.searchText.isEmpty {
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
                    ForEach(viewModel.filteredCities, id: \.self) { city in
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
        .onChange(of: viewModel.searchText) { _ in
            viewModel.updateSearchingState()
        }
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
