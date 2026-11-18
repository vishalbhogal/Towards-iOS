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
    @State private var viewModel: LessonCatalogViewable
    init(viewModel: LessonCatalogViewable) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationStack {
            List {
                switch viewModel.loadState {
                case .loading:
                    ProgressView()
                    
                case .loaded(let lessons):
                    ForEach(lessons) { lessonValue in
                        VStack(alignment: .leading) {
                            HStack(alignment: .center, spacing: 16) {
                                Text(lessonValue.number.formatted(.number.precision(.integerLength(2))))
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
                                .padding(.horizontal, 8)
                                    
                            }
                        }
                        .padding(8) // Gives the background breathing room around your text
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
                await viewModel.getLessons()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: LessonCatalogViewModel(service: LessonCatalogService()))
}
