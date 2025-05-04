//
//  RouteInputFieldsView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 21.04.2025.
//

import SwiftUI

struct RouteInputFields: View {
    @ObservedObject var viewModel: RouteInputViewModel
    @Binding var navigationPath: NavigationPath
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool {
        colorScheme == .dark
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.innerCornerRadius)
                .fill(Color.blueYP)
                .frame(height: Constants.inputFieldsHeight)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: Constants.fieldsSpacing) {
                    inputField(isFromField: true)
                    inputField(isFromField: false)
                }
                .padding(Constants.textFieldsPadding)
                .background(Color.white)
                .cornerRadius(Constants.innerCornerRadius)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                
                swapButton
            }
        }
        .frame(height: Constants.inputFieldsHeight) // Фиксированная высота
    }
    
    private func inputField(isFromField: Bool) -> some View {
        Button(action: {
            navigationPath.append(Destination.choiceCity(fromField: isFromField))
        }) {
            Text(viewModel.displayText(isFromField: isFromField))
                .foregroundColor(textColor(for: viewModel.displayText(isFromField: isFromField)))
                .font(.system(size: Constants.fontSize))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: Constants.inputFieldHeight)
    }

    private func textColor(for text: String) -> Color {
        if text == "Откуда" || text == "Куда" {
            return .gray
        } else {
            return .blackYP // Всегда черный, исправления для ревью
        }
    }
    
    private var swapButton: some View {
        Button(action: viewModel.swapStations) {
            Image("switch_arrow")
                .foregroundColor(.blueYP)
                .padding(Constants.swapButtonPadding)
                .background(Color.white)
                .clipShape(Circle())
        }
        .padding(.trailing, 10)
    }
}

// MARK: - Preview
//#Preview {
//    // Создаем моковый ViewModel для превью
//    let mockViewModel = RouteInputViewModel()
//    
//    // Создаем тестовые станции
//    let moscowStation = Station(name: "Москва")
//    let petersburgStation = Station(name: "Санкт-Петербург")
//    
//    // Настраиваем ViewModel
//    mockViewModel.fromStation = moscowStation
//    mockViewModel.toStation = petersburgStation
//    
//    // Создаем состояние для navigationPath
//    @State var navigationPath = NavigationPath()
//    
//    return RouteInputFields(
//        viewModel: mockViewModel,
//        navigationPath: $navigationPath
//    )
//    .padding()
//}
