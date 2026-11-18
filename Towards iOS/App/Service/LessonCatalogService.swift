//
//  LessonCatalogService.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 19/11/26.
//

import Foundation

protocol LessonCatalogServiceProtocol {
    func load() async throws -> [Lesson]
}

enum LessonCatalogServiceErrorState: LocalizedError {
    case error(String)
    var errorDescription: String? {
        switch self {
        case .error(let message):
            return message
        }
    }
}

nonisolated struct LessonCatalogService: LessonCatalogServiceProtocol, Sendable {
    let bundle: Bundle = .main
    let resourceFileName: String
    
    init(resourceFileName: String = "lessons") {
        self.resourceFileName = resourceFileName
    }
    
    @concurrent
    func load() async throws -> [Lesson] {
        guard let url = bundle.url(forResource: resourceFileName, withExtension: "json") else {
            throw LessonCatalogServiceErrorState.error("Couldn't find the lessons.json file in the bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw LessonCatalogServiceErrorState.error("Couldn't load the lessons.json file.")
        }

        do {
            let result = try JSONDecoder().decode(LessonCatalog.self, from: data)
            return result.phases.flatMap(\.lessons)
        } catch {
            throw LessonCatalogServiceErrorState.error(String(describing: error))
        }
    }
}
