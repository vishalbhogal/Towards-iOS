//
//  ContentView.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 11/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var errorText: String?
    @State private var lessons: [Lesson]?
    
    var body: some View {
        NavigationStack {
            List {
                if let errorText {
                    Text(errorText)
                } else if let lessons {
                    ForEach(lessons) { lesson in
                        Section(lesson.title, content: {
                            Text(lesson.body)
                                .font(.body)
                        })
                    }.navigationTitle("Summary")
                } else {
                    ProgressView()
                }
            }.task {
                load()
            }
        }
    }

    private func load() {
        guard let url = Bundle.main.url(forResource: "lessons", withExtension: ".json") else {
            errorText = "Couldn't find lessons.json in the bundle."
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            errorText = "Couldn't derive data from the bundle."
            return
        }
        
        guard let result = try? JSONDecoder().decode(LessonCatalog.self, from: data) else {
            errorText = "Couldn't decode LessonCatalog from data."
            return
        }
        
        self.lessons = result.phases.flatMap(\.lessons)
        return
    }
}

#Preview {
    ContentView()
}
