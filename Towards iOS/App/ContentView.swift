//
//  ContentView.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 11/11/26.
//

import SwiftUI

/// Temporary root view for TI-2: proves the bundled lessons.json decodes into the models.
/// TI-3 replaces the inline decoding with LessonRepository, and #15 replaces this view with the TabView.
struct ContentView: View {
    @State private var lessons: [Lesson] = []
    @State private var errorText: String?

    var body: some View {
        NavigationStack {
            List {
                if let errorText {
                    Text(errorText).foregroundStyle(.red)
                }
                ForEach(lessons) { lesson in
                    VStack(alignment: .leading) {
                        Text("\(lesson.number). \(lesson.title)")
                        Text(lesson.meta).font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Lessons")
        }
        .task { load() }
    }

    private func load() {
        guard let url = Bundle.main.url(forResource: "lessons", withExtension: "json") else {
            errorText = "lessons.json is missing from the app bundle"
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let catalog = try JSONDecoder().decode(LessonCatalog.self, from: data)
            lessons = catalog.phases.flatMap(\.lessons)
        } catch {
            errorText = String(describing: error)
        }
    }
}

#Preview {
    ContentView()
}
