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

// MARK: - Suggested implementation (reference only, uncomment to compare)
// Conformances (point 7) are left out on purpose. Add them once you've gone through the protocols.
// Status is derived from `lessons` order plus the set of completed ids, never stored.
//
// struct Phase {
//     let id: String
//     let number: Int
//     let title: String
//     let lessons: [Lesson]
//
//     /// done if finished, next if it's the first unfinished lesson, otherwise locked.
//     func status(of lesson: Lesson, completed: Set<Lesson.ID>) -> LessonStatus {
//         if completed.contains(lesson.id) { return .done }
//         if nextLesson(completed: completed)?.id == lesson.id { return .next }
//         return .locked
//     }
//
//     /// The first lesson, in order, that isn't finished. nil when the whole phase is done.
//     /// No count shortcut: `completed` may also hold ids from other phases.
//     func nextLesson(completed: Set<Lesson.ID>) -> Lesson? {
//         lessons.first { !completed.contains($0.id) }
//     }
//
//     /// How many of THIS phase's lessons are finished (ignores ids from other phases).
//     func doneCount(completed: Set<Lesson.ID>) -> Int {
//         lessons.count { completed.contains($0.id) }   // Swift 6 `count(where:)`
//     }
// }
//
// Quick check you can paste into a #Preview or test:
//
// let phase = Phase(id: "p1", number: 1, title: "Foundations", lessons: [
//     Lesson(id: "p1.a", number: 1, title: "A", meta: "", minutes: 5, body: "", codeSample: "", keyPoints: []),
//     Lesson(id: "p1.b", number: 2, title: "B", meta: "", minutes: 5, body: "", codeSample: "", keyPoints: []),
//     Lesson(id: "p1.c", number: 3, title: "C", meta: "", minutes: 5, body: "", codeSample: "", keyPoints: []),
// ])
// let done: Set<Lesson.ID> = ["p1.a", "p2.other"]          // includes an id from another phase
// phase.status(of: phase.lessons[0], completed: done)       // .done
// phase.status(of: phase.lessons[1], completed: done)       // .next
// phase.status(of: phase.lessons[2], completed: done)       // .locked
// phase.doneCount(completed: done)                          // 1, not 2
// phase.nextLesson(completed: ["p1.a", "p1.b", "p1.c"])     // nil
