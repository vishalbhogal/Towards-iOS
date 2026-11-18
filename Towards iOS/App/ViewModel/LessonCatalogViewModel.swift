//
//  LessonCatalogViewModel.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 19/11/26.
//

import Foundation

protocol LessonCatalogViewable: AnyObject, Observable {
    func getLessons() async
    var loadState: LoadState { get }
}

@Observable
class LessonCatalogViewModel: LessonCatalogViewable {
    private(set) var loadState: LoadState = .loading
    private let service: LessonCatalogServiceProtocol
    
    required init(service: LessonCatalogServiceProtocol) {
        self.service = service
    }
    
    
    func getLessons() async {
        do {
            let result = try await service.load()
            loadState = .loaded(result)
        } catch {
            loadState = .error(error.localizedDescription)
        }
    }
}
