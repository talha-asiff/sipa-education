import 'package:flutter/material.dart';

import 'account_page.dart';
import 'app_shell.dart';
import 'auth_gate.dart';
import 'courses_page.dart';
import 'login_page.dart';
import 'logic.dart';
import 'signup_page.dart';
import 'subscription_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const wine = Color(0xFF780147);
    const canvas = Color(0xFFF8F5F7);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIPA Education',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: wine),
        scaffoldBackgroundColor: canvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: Color(0xFF2D1B26),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7DDE3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE7DDE3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: wine, width: 1.5),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => AuthGate(child: const MyHomePage()),
        '/courses': (context) => AuthGate(child: const CoursesPage()),
        '/subscription': (context) => AuthGate(child: const SubscriptionPage()),
        '/account': (context) => AuthGate(child: const AccountPage()),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _courseScrollController = ScrollController();

  @override
  void dispose() {
    _courseScrollController.dispose();
    super.dispose();
  }

  void _scrollCourses(double direction) {
    if (!_courseScrollController.hasClients) return;

    final position = _courseScrollController.position;
    final targetOffset = (position.pixels + direction * 336)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();

    _courseScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Dashboard',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your learning',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your registered courses, all in one place.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pushNamed('/courses'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Browse catalog'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ValueListenableBuilder<Map<String, Course>>(
            valueListenable: registeredCourses,
            builder: (context, courses, _) {
              if (courses.isEmpty) return _buildEmptyCourses(context);

              final courseList = courses.values.toList();
              return LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = (constraints.maxWidth - 80)
                      .clamp(240.0, 360.0)
                      .toDouble();
                  final needsArrows =
                      courseList.length > 1 ||
                      constraints.maxWidth < cardWidth + 112;

                  return SizedBox(
                    height: 224,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ListView.builder(
                          controller: _courseScrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          scrollDirection: Axis.horizontal,
                          itemCount: courseList.length,
                          itemBuilder: (context, index) {
                            final course = courseList[index];
                            return Container(
                              width: cardWidth,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(0xFFECE4E9),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0D381126),
                                    blurRadius: 18,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF7EAF1),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Icon(
                                          course.icon,
                                          color: const Color(0xFF780147),
                                        ),
                                      ),
                                      const Spacer(),
                                      const _EnrolledChip(),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    course.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Ready when you are.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        if (needsArrows) ...[
                          Positioned(
                            left: 4,
                            child: IconButton.filledTonal(
                              tooltip: 'Scroll courses left',
                              onPressed: () => _scrollCourses(-1),
                              icon: const Icon(Icons.chevron_left_rounded),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            child: IconButton.filledTonal(
                              tooltip: 'Scroll courses right',
                              onPressed: () => _scrollCourses(1),
                              icon: const Icon(Icons.chevron_right_rounded),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF780147), Color(0xFF9B286A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<DemoUser?>(
              valueListenable: currentUser,
              builder: (context, user, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, ${user?.name ?? 'learner'}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Small steps today can lead to big things tomorrow.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.88),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.auto_stories_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCourses(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFECE4E9)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 42,
            color: Color(0xFF780147),
          ),
          const SizedBox(height: 12),
          Text(
            'Your learning journey starts here',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Choose a course from the catalog to add it to your dashboard.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pushNamed('/courses'),
            icon: const Icon(Icons.explore_outlined),
            label: const Text('Explore courses'),
          ),
        ],
      ),
    );
  }
}

class _EnrolledChip extends StatelessWidget {
  const _EnrolledChip();

  @override
  Widget build(BuildContext context) {
    return const Chip(
      label: Text('Enrolled'),
      avatar: Icon(Icons.check_circle_rounded, size: 16),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
      backgroundColor: Color(0xFFEAF4EE),
      labelStyle: TextStyle(
        color: Color(0xFF276343),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
