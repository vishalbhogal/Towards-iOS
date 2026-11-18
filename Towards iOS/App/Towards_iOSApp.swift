//
//  Towards_iOSApp.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 11/11/26.
//

import SwiftUI

@main
struct Towards_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: LessonCatalogViewModel(service: LessonCatalogService()))
        }
    }
}
