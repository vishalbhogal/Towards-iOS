# SwiftPath

**An iOS app that teaches iOS development, built in SwiftUI.** Each lesson's live demo is the exercise you build to learn that concept, so the app grows as your skills do.

SwiftPath is being built over about 20 weeks as preparation for senior iOS engineering roles, and is planned for release on the App Store.

> Working title: SwiftPath. Repository: `Towards-iOS`.

---

## Learning roadmap

| Phase | Focus | Length | What you build and learn |
|---|---|---|---|
| 1 | **Foundations** | 3 weeks | Views, modifiers, `@State` / `@Binding`, lists, `NavigationStack`, design system |
| 2 | **Data flow and interaction** | 3 weeks | `@Observable`, environment, the quiz flow, animation and transitions |
| 3 | **Persistence and testing** | 3 weeks | SwiftData for progress, Swift packages, Swift Testing |
| 4 | **Concurrency and quality** | 4 weeks | Swift 6 strict concurrency, accessibility, localization (second language) |
| 5 | **Advanced SwiftUI and performance** | 3 weeks | Custom `Layout`, view identity, Instruments, widgets |
| 6 | **Production and release** | 4 weeks | CloudKit sync, CI, TestFlight, App Store launch |

## Current status

🚧 **Phase 1: Foundations** is in progress.

- Tracked in the [Phase 1: Foundations milestone](https://github.com/vishalbhogal/Towards-iOS/milestone/1)
- Epic [#1](https://github.com/vishalbhogal/Towards-iOS/issues/1) with 5 stories and 27 tasks (about 48 hours):
  - [#2](https://github.com/vishalbhogal/Towards-iOS/issues/2) Project setup and design system
  - [#8](https://github.com/vishalbhogal/Towards-iOS/issues/8) Lesson data from JSON
  - [#14](https://github.com/vishalbhogal/Towards-iOS/issues/14) Learn screen (The Path)
  - [#22](https://github.com/vishalbhogal/Towards-iOS/issues/22) Lesson detail screen
  - [#29](https://github.com/vishalbhogal/Towards-iOS/issues/29) Quality and exit check

**Phase 1 is done when** the Learn and Lesson screens match the designs, run from `lessons.json` with 7 lessons, and all previews and tests pass.

## Tech stack

- **UI:** SwiftUI, iOS 18+, Swift 6 language mode
- **Content:** lessons bundled as JSON (`lessons.json`)
- **Progress:** SwiftData (Phase 3); in memory during Phase 1
- **Settings:** `@AppStorage`
- **Sync:** optional CloudKit (Phase 6)
- **Tests:** Swift Testing (`@Test`)
- No backend.

## Design

Bold and minimal: white background, ink black, and one signal red that only ever means "next".

| Token | Hex | SwiftUI |
|---|---|---|
| paper | `#FFFFFF` | `Color.paper` |
| ink | `#111111` | `Color.ink` |
| signal | `#FF3B1F` | `Color.signal` |
| fill | `#F5F5F5` | `Color.fill` |
| line | `#E5E5E5` | `Color.line` |
| muted | `#707070` | `Color.muted` |

Fonts: **Anton** (uppercase headlines), **Inter Tight** (UI), **JetBrains Mono** (code). All are free to bundle and scale with Dynamic Type.

## Getting started

### Requirements

- macOS with **Xcode 16** or later
- iOS 18 simulator or device

### Run the app

```bash
git clone https://github.com/vishalbhogal/Towards-iOS.git
cd Towards-iOS
open "Towards iOS.xcodeproj"
```

1. Select the **Towards iOS** scheme and an iPhone simulator.
2. Press **⌘R** to build and run.
3. Press **⌘U** to run the tests.

To run on your own iPhone, open the target's **Signing & Capabilities** tab and pick your team.

### Project structure

```
Towards iOS/
├── App/            # App entry point and root TabView
├── Features/       # Learn, Lesson, Practice, Profile screens
├── Models/         # Phase, Lesson, LessonLoader
├── DesignSystem/   # Colors, fonts, PillButtonStyle, shared components
└── Resources/      # lessons.json, fonts, assets
```

## Tracking work

All work is tracked as GitHub issues, grouped by phase milestone and shown on the project board.

- **Epic** = a phase, **Story** = a feature, **Task** = one focused piece of work (1 to 4 hours).
- Labels show the area: `setup`, `design-system`, `data`, `learn-screen`, `lesson-screen`, `navigation`, `testing`, `accessibility`, `quality`, `interview-prep`.
- Every task has a **"Done when"** acceptance check.

### Workflow

1. Pick the next open task in the current milestone and move it to **In Progress** on the board.
2. Branch from `main`: `git checkout -b task/<issue-number>-short-name`
3. Commit in small steps, then open a pull request.
4. Put `Closes #<issue-number>` in the PR description so the task closes when it merges.
5. Check previews (light, dark, largest text size) and tests before merging.

### Definition of done

- Matches the design and the task's "Done when" check
- `#Preview` works in light mode, dark mode and accessibility text sizes
- Tests pass, and there are no force unwraps
- Every control has a VoiceOver label

## Learning notes

At the end of each phase, write short notes explaining the key ideas in your own words (for example: why views are structs, why modifier order matters, `@State` vs `@Binding`). These double as interview prep.

## License

All rights reserved. (Add a license before making the repository public.)
