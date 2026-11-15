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
                    ForEach(lessons.enumerated(), id: \.element) { index, lessonValue in
                        VStack(alignment: .leading) {
                            HStack(alignment: .center, spacing: 16) {
                                Text("0\(index + 1)")
                                    .foregroundStyle(.ink)
                                    .font(.spRowNumber)
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading) {
                                        Text(lessonValue.title)
                                            .font(.spButton)
                                            .foregroundStyle(.ink)
                                            .padding(.bottom, 2)
                                        
                                        Text(lessonValue.meta)
                                            .foregroundStyle(.muted)
                                            .font(.spSubhead)
                                    }
                                    Spacer()
                                    Image(systemName: "lock")
                                        .foregroundStyle(.muted)
                                }
                                    
                            }
                        }
                        .padding() // Gives the background breathing room around your text
                        .background(Color.fill) // Replace with your custom color
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .listRowBackground(Color.fill) // fills the List cell behind the row, including its insets
                    }
                    
                    
                case .error(let error):
                Text(error)
                    .foregroundStyle(.signal)
                }
            }
            
            .navigationTitle("All Lessons")
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
