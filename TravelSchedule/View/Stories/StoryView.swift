//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoryView: View {
    let content: ContentStory

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.blackYP
                .ignoresSafeArea()

            Image(content.big)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 40))

            storyText
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
        }
    }

    // Вынесенный компонент для текста
    private var storyText: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            Text(content.title)
                .font(.bold34)
                .foregroundColor(.white)
                .lineLimit(2)
            Text(content.description)
                .font(.regular20)
                .foregroundColor(.white)
                .lineLimit(3)
        }
    }
}

// MARK: - Preview
#Preview {
    StoryView(
        content: ContentStory(
            big: .big1,
            title: "Sample Story Title",
            description: "Sample description text for the story. It should be a few lines long to see how it looks."
        )
    )
}
