//
//  ContentView.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 11/11/26.
//

import SwiftUI

enum LoadState {
    case loading
    case loaded([Lesson])
    case error(String)
}

struct ContentView: View {
    @State private var state: LoadState = .loading
    
    var body: some View {
        NavigationStack {
            List {
                switch state {
                case .loading:
                    ProgressView()
                    
                case .loaded(let lessons):
                    ForEach(lessons) { lesson in
                        Section(lesson.title, content: {
                            Text(lesson.body)
                                .foregroundStyle(.ink)
                                .font(.spBody)
                        }).font(.spHeadline)
                    }
                    
                case .error(let error):
                Text(error)
                    .foregroundStyle(.signal)
                }
            }
            .navigationTitle("Towards iOS")
            .task {
                load()
            }
        }
    }

    private func load() {
        guard let url = Bundle.main.url(forResource: "lessons", withExtension: "json") else {
            state = .error("Couldn't find lessons.json in the bundle.")
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            state = .error("Couldn't derive data from the bundle.")
            return
        }
        
        do {
            let result = try JSONDecoder().decode(LessonCatalog.self, from: data)
            let resultLessons = result.phases.flatMap(\.lessons)
            state = .loaded(resultLessons)
        } catch {
            state = .error(String(describing: error))
        }
    }
}

#Preview {
    ContentView()
}
