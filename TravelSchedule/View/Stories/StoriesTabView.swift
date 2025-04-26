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
        TabView(selection: $currentContentIndex) {
            ForEach(currentContentStories) { content in
                StoryView(content: content)
                    .onTapGesture {
                        didTapContent()
                    }
                    .tag(currentContentStories.firstIndex(of: content) ?? 0)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    private func didTapContent() {
        currentContentIndex = min(currentContentIndex + 1, currentContentStories.count - 1)
    }
}

