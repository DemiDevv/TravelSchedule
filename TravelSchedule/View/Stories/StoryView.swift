//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story  // Теперь принимает Story, а не ContentStory
    @State private var currentContentIndex = 0

    var body: some View {
        ZStack {
            // Отображаем текущий ContentStory
            Image(story.story[currentContentIndex].big)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.3))
            
            // Контент поверх изображения
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.story[currentContentIndex].title)
                        .font(.bold34)
                        .foregroundColor(.white)
                    Text(story.story[currentContentIndex].description)
                        .font(.regular20)
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
            }
        }
        .onTapGesture {
            // Переход к следующему ContentStory или следующей Story
            if currentContentIndex < story.story.count - 1 {
                currentContentIndex += 1
            } else {
                // Здесь можно закрыть StoryView или перейти к следующей Story
            }
        }
    }
}


