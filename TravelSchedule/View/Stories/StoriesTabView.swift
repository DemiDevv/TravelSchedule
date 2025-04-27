//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    @Binding var currentContentIndex: Int

    private var currentContentStories: [ContentStory] {
        stories[currentStoryIndex].story
    }

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentContentIndex) {
                ForEach(currentContentStories) { content in
                    StoryView(content: content)
                        .contentShape(Rectangle()) // Важно: чтобы весь экран ловил нажатия
                        .onTapGesture { location in
                            didTapContent(at: location, in: geometry.size)
                        }
                        .tag(currentContentStories.firstIndex(of: content) ?? 0)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    private func didTapContent(at location: CGPoint, in size: CGSize) {
        let isLeftSide = location.x < size.width / 2
        
        if isLeftSide {
            // Нажали слева — назад
            currentContentIndex = max(currentContentIndex - 1, 0)
        } else {
            // Нажали справа — вперёд
            currentContentIndex = min(currentContentIndex + 1, currentContentStories.count - 1)
        }
    }
}
