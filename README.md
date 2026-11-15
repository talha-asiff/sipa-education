# CIPA International

A Flutter app with six navigable tabs: Home, Courses, Catalog, Billing &
Pricing, Profile, and Settings. Home shows the course dashboard; the other tabs
are empty-state placeholders ready for page content.

## Run the app

Install the Flutter SDK and configure a device, emulator, or desktop target,
then run:

```shell
flutter pub get
flutter run
```

Run the widget tests and analyzer with:

```shell
flutter test
flutter analyze
```

## How the tabs work

The app starts in `main()` in `lib/main.dart`. `runApp()` mounts `MyApp`, which
creates a `MaterialApp` with the app title, Material 3 theme, and `PagesHome` as
its first screen.

`PagesHome` defines the tab labels and icons in the `_pages` list. A
`DefaultTabController` manages which tab is selected. Its `TabBar` builds a
tab for each item in that list, and its `TabBarView` displays the corresponding
page. The tab bar is horizontally scrollable, so all tabs remain available on
narrow screens.

The Home tab displays the course heading and a horizontally scrolling course
area. The other tab views are `_EmptyTabPage` widgets. Each receives its
`_TabPage` data and shows the matching icon and title, followed by a message
that the page is empty. To add content to one of these pages, replace or extend
`_EmptyTabPage` and use the `page` value to choose what to display. `_TabPage`
is a small immutable data class that pairs each tab's label with its Material
icon.

## Project files

- `lib/main.dart` contains the app entry point, tab definitions, tab controller
  setup, Home dashboard, and placeholder page UI.
- `test/widget_test.dart` checks that Home renders and that selecting Courses
  and Billing & Pricing opens their matching placeholder pages.
- `pubspec.yaml` defines the Flutter SDK and dependencies. The interface uses
  Flutter's built-in Material widgets and icons.
