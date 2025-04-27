//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoriesView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    var onClose: () -> Void
    
    @State private var currentContentIndex: Int = 0
    @State private var currentProgress: CGFloat = 0
    @GestureState private var dragOffset: CGSize = .zero

    private var timerConfiguration: TimerConfiguration {
        .init(storiesCount: currentContentStories.count)
    }
    
    private var currentContentStories: [ContentStory] {
        stories[currentStoryIndex].story
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Основной контент историй
            StoriesTabView(
                stories: stories,
                currentStoryIndex: $currentStoryIndex,
                currentContentIndex: $currentContentIndex
            )
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        if value.translation.height > 0 {
                            state = value.translation
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 {
                            onClose()
                        }
                    }
            )
            
            StoriesProgressBar(
                storiesCount: currentContentStories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.horizontal, 12)
            .padding(.top, 79)
            
            CloseButton(action: onClose)
                .padding(.top, 104)
                .padding(.trailing, 12)
        }
        .background(Color.black)
        .onChange(of: currentContentIndex) { oldValue, newValue in
            didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
        }
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
}
