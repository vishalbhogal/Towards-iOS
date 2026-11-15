//
//  LessonModel.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 15/11/26.
//

import Foundation

nonisolated
struct Phase: Identifiable, Codable {
    let id: String
    let number: Int
    let title: String
    let lessons: [Lesson]
    
    func findLessonStatus(lesson: Lesson, completed: Set<Lesson.ID>) ->  LessonStatus {
        if completed.contains(lesson.id) {
            return .done
        }
        
        let nextLesson = findNextLesson(completed: completed)
        if lesson.id == nextLesson?.id {
            return .next
        }
        return .locked
    }
    
    func findNextLesson(completed: Set<Lesson.ID>) -> Lesson? {
        return lessons.first { !completed.contains($0.id) }
    }

    func doneCount(completed: Set<Lesson.ID>) -> Int {
        return lessons.count { completed.contains($0.id) }
    }
}

nonisolated
enum LessonStatus {
    case done, next, locked
}

nonisolated
struct Lesson: Codable, Hashable, Identifiable {
    let id: String
    let number: Int
    let title: String
    let meta: String
    let minutes: Int
    let body: String
    let codeSample: String
    let keyPoints: [String]
}


nonisolated
struct LessonCatalog: Codable {
    let version: Int
    let phases: [Phase]
}
