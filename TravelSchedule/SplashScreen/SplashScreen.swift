//
//  SplashScreen.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 17.04.2025.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isActive: Bool // Управляем состоянием экрана загрузки

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Показываем изображение, растягиваем его по экрану
                Image("splash_screen") // Замените на имя вашего изображения
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Заполняем экран, сохраняя пропорции
                    .frame(width: geometry.size.width, height: geometry.size.height) // Растягиваем изображение на весь экран
                    .clipped() // Обрезаем лишнее, если изображение выходит за пределы экрана
            }
        }
        .edgesIgnoringSafeArea(.all) // Игнорируем безопасные области (например, верхнюю и нижнюю панели)
        .onAppear {
            // Через 3 секунды сменим состояние isActive на false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}
