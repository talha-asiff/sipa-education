# CIPA International

CIPA International is a sample O Level and A Level learning dashboard built
with Flutter. It uses a bold, playful **brutalist** style: warm paper-colored
backgrounds, thick black outlines, hard shadows, bright subject colors, and
heavy headings.

The app is a front-end demonstration. Course details, learner progress, and
video lessons are sample data stored in the Dart source. The video cards open a
preview dialog; they do not stream real video.

## Run the app

Install Flutter and set up a device, emulator, or desktop target. From the
project folder run:

```shell
flutter pub get
flutter run
```

Check the code and run the widget tests with:

```shell
flutter analyze
flutter test
```

## What is in the dashboard

- **Home:** a welcome banner, learning statistics, a featured biology lesson,
  video previews, and a short list of courses.
- **Courses:** the learner's courses and a search field that filters by course
  title, subject, or O/A Level.
- **Catalog:** the complete sample course list.
- **Video library:** all sample video lessons.
- **Billing & Pricing** and **Profile:** simple starter pages that can be
  replaced with real account features.
- **Video preview:** clicking a lesson opens a dialog with its subject,
  duration, thumbnail, and a note explaining that the content is a placeholder.

On wide screens, navigation is a left sidebar. On smaller screens, the first
four sections appear in a bottom navigation bar. The page content scrolls
vertically, and course cards reflow into fewer columns on narrow displays.

## Code tour: `lib/main.dart`

The app intentionally keeps its example code in one file so it is easy to
follow. Widgets are separated into small classes, each responsible for one
part of the screen.

### Start-up and styling

- `main()` calls `runApp()` with `CipaApp`.
- `CipaApp` creates the `MaterialApp`, sets the app title, and defines the
  shared color scheme and background.
- The color constants (`ink`, `paper`, `yellow`, `coral`, and `mint`) are used
  throughout the interface. Change them to adjust the visual theme.

### Sample content

- `Course` describes a course: title, subject, level, lesson count, color, and
  icon.
- `courses` is the list of four sample O/A Level courses. Add or edit entries
  here to change the course cards.
- `VideoLesson` describes a sample lesson with a title, subject, duration,
  color, and icon.
- `videos` is the list used by the dashboard and video library. Replace these
  preview records with real content and a video player when one is available.
- `_Section` and `sections` define the names and icons used by navigation.

### Navigation and page state

- `DashboardShell` is the stateful app frame. It stores the selected section
  and the current search text.
- `_buildPage()` chooses which page to show based on the selected section.
- `_Sidebar` and `_NavItem` build wide-screen navigation.
- `_TopBar` contains the responsive header and search input. The search text is
  passed to the course page so course results update as the user types.
- The `NavigationBar` in `DashboardShell` is used on smaller screens.
- `openVideo()` opens `VideoPreviewDialog` for the selected sample lesson.

### Home dashboard

- `_HomePage` arranges the homepage sections and sends navigation or video
  actions back to `DashboardShell`.
- `_WelcomeHero` is the yellow greeting banner.
- `_StatsRow` and `_StatCard` show the sample learning statistics.
- `_SectionHeading` provides a reusable heading with an action button.
- `_ContinueCard` displays the current lesson and progress.
- `_LessonArtwork` draws the colorful lesson cover using built-in icons.
- `_Pill`, `_ProgressBar`, and `_BlockButton` are small reusable UI elements.
- `_VideoRow` and `_VideoCard` show clickable sample lessons.

### Courses and other pages

- `_CoursePage` filters the course list using the search text.
- `_CourseGrid` chooses how many columns fit the available width.
- `_CourseCard` displays each course's level, subject, icon, and lesson count.
- `_EmptySearch` explains when a search has no matches.
- `_VideoLibraryPage` lists all sample lessons.
- `_InfoPage` is a simple reusable page for profile and billing sections.
- `_PageIntro` provides a consistent heading panel for those pages.
- `VideoPreviewDialog` displays a placeholder preview and closes with the close
  button.

Names beginning with an underscore are private to this Dart file. This is a
common Dart convention for implementation details that are not part of a
package's public API.

## Project files

- `lib/main.dart` contains the interface, sample content, and navigation logic.
- `test/widget_test.dart` checks the dashboard, course search, preview dialog,
  and small-screen layout.
- `pubspec.yaml` declares the Flutter SDK and package dependencies. The
  dashboard uses Flutter's built-in Material widgets and icons.
- The `android/`, `ios/`, `web/`, `windows/`, `linux/`, and `macos/` folders
  contain Flutter's platform-specific runner projects.

## Connecting real content

The dashboard currently uses in-memory sample lists. A next step for a
production app would be to load courses and progress from an API or database,
add sign-in and authorization, and connect `VideoPreviewDialog` to a licensed
video player and real lesson URLs. Keep private keys and service credentials
out of the client app.
