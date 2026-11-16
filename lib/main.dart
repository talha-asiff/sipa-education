import 'package:flutter/material.dart';

void main() {
  runApp(const CipaApp());
}

const ink = Color(0xFF171717);
const paper = Color(0xFFF5F1E8);
const yellow = Color(0xFFF6D84A);
const coral = Color(0xFFFF795E);
const mint = Color(0xFFA8D9C5);

class CipaApp extends StatelessWidget {
  const CipaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CIPA International',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: yellow,
          surface: paper,
          onSurface: ink,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: ink),
          bodyLarge: TextStyle(color: ink),
        ),
      ),
      home: const DashboardShell(),
    );
  }
}

class Course {
  const Course({
    required this.title,
    required this.subject,
    required this.level,
    required this.lessons,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subject;
  final String level;
  final int lessons;
  final Color color;
  final IconData icon;
}

const courses = [
  Course(
    title: 'Ultimate Biology',
    subject: 'Biology',
    level: 'A LEVEL',
    lessons: 32,
    color: mint,
    icon: Icons.biotech,
  ),
  Course(
    title: 'Chemistry, Unlocked',
    subject: 'Chemistry',
    level: 'A LEVEL',
    lessons: 28,
    color: yellow,
    icon: Icons.science,
  ),
  Course(
    title: 'Physics in Motion',
    subject: 'Physics',
    level: 'O LEVEL',
    lessons: 24,
    color: Color(0xFFB7C7FF),
    icon: Icons.bolt,
  ),
  Course(
    title: 'Maths Without Fear',
    subject: 'Mathematics',
    level: 'O LEVEL',
    lessons: 30,
    color: Color(0xFFFFB8C5),
    icon: Icons.functions,
  ),
];

const videos = [
  VideoLesson(
    title: 'Cell structure: the basics',
    subject: 'BIOLOGY',
    duration: '12:48',
    color: mint,
    icon: Icons.biotech,
  ),
  VideoLesson(
    title: 'Balancing equations',
    subject: 'CHEMISTRY',
    duration: '09:32',
    color: yellow,
    icon: Icons.science,
  ),
  VideoLesson(
    title: 'Forces & free-body diagrams',
    subject: 'PHYSICS',
    duration: '15:06',
    color: Color(0xFFB7C7FF),
    icon: Icons.bolt,
  ),
];

class VideoLesson {
  const VideoLesson({
    required this.title,
    required this.subject,
    required this.duration,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subject;
  final String duration;
  final Color color;
  final IconData icon;
}

const sections = [
  _Section('Home', Icons.home_outlined),
  _Section('Courses', Icons.menu_book_outlined),
  _Section('Catalog', Icons.grid_view_outlined),
  _Section('Video library', Icons.play_circle_outline),
  _Section('Billing & Pricing', Icons.receipt_long_outlined),
  _Section('Profile', Icons.person_outline),
];

class _Section {
  const _Section(this.label, this.icon);

  final String label;
  final IconData icon;
}

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int selectedSection = 0;
  String searchQuery = '';

  void openVideo(VideoLesson video) {
    showDialog<void>(
      context: context,
      builder: (context) => VideoPreviewDialog(video: video),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wideLayout = constraints.maxWidth >= 900;
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (wideLayout)
                  _Sidebar(
                    selectedIndex: selectedSection,
                    onSelected: (index) =>
                        setState(() => selectedSection = index),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _TopBar(
                        onSearchChanged: (value) =>
                            setState(() => searchQuery = value),
                      ),
                      Expanded(child: _buildPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: wideLayout
              ? null
              : NavigationBar(
                  selectedIndex: selectedSection,
                  onDestinationSelected: (index) =>
                      setState(() => selectedSection = index),
                  backgroundColor: paper,
                  indicatorColor: yellow,
                  destinations: sections
                      .take(4)
                      .map(
                        (section) => NavigationDestination(
                          icon: Icon(section.icon),
                          label: section.label,
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }

  Widget _buildPage() {
    switch (selectedSection) {
      case 0:
        return _HomePage(
          onPlay: openVideo,
          onSectionSelected: (index) => setState(() => selectedSection = index),
        );
      case 1:
        return _CoursePage(
          title: 'Your courses',
          description: 'Pick up where you left off.',
          searchQuery: searchQuery,
        );
      case 2:
        return _CoursePage(
          title: 'Course catalog',
          description: 'Big ideas. Brilliant teachers. Better grades.',
          searchQuery: searchQuery,
        );
      case 3:
        return _VideoLibraryPage(onPlay: openVideo);
      case 4:
        return const _InfoPage(
          title: 'Billing & Pricing',
          description: 'Straightforward plans for ambitious learners.',
          icon: Icons.receipt_long_outlined,
        );
      default:
        return const _InfoPage(
          title: 'Your profile',
          description: 'Your learning journey, all in one place.',
          icon: Icons.person_outline,
        );
    }
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 238,
      decoration: const BoxDecoration(
        color: paper,
        border: Border(right: BorderSide(color: ink, width: 2)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Brand(),
          const SizedBox(height: 48),
          const _SmallLabel('LEARNING SPACE'),
          const SizedBox(height: 12),
          for (var index = 0; index < sections.length; index++)
            _NavItem(
              section: sections[index],
              selected: index == selectedIndex,
              onTap: () => onSelected(index),
            ),
          const Spacer(),
          const _SidebarNote(),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: yellow,
            border: Border.all(color: ink, width: 2),
            boxShadow: const [BoxShadow(color: ink, offset: Offset(3, 3))],
          ),
          child: const Icon(Icons.school_outlined, color: ink),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'CIPA\nINTERNATIONAL',
            style: TextStyle(
              fontSize: 13,
              height: 1.1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _SmallLabel extends StatelessWidget {
  const _SmallLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.4,
        color: Color(0xFF666158),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  final _Section section;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: selected ? yellow : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: ink, width: selected ? 2 : 1),
            ),
            child: Row(
              children: [
                Icon(section.icon, size: 19),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.label,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                if (selected) const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarNote extends StatelessWidget {
  const _SidebarNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ink,
        border: Border.all(color: ink, width: 2),
      ),
      child: const Text(
        'SMALL STEPS.\nBIG RESULTS.',
        style: TextStyle(
          color: paper,
          height: 1.4,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 600;
        return Container(
          height: 76,
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 28),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: ink, width: 2)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  compact ? 'CIPA' : 'MONDAY, 16 NOVEMBER',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                width: compact ? 150 : 230,
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search courses',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: const BorderSide(color: ink, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: const BorderSide(color: ink, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: const BorderSide(color: ink, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: coral,
                  border: Border.all(color: ink, width: 2),
                ),
                child: const Text(
                  'S',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({required this.onPlay, required this.onSectionSelected});

  final ValueChanged<VideoLesson> onPlay;
  final ValueChanged<int> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 650;
        final padding = compact ? 18.0 : 32.0;
        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WelcomeHero(compact: compact),
              const SizedBox(height: 22),
              const _StatsRow(),
              const SizedBox(height: 34),
              _SectionHeading(
                eyebrow: 'BACK IN THE FLOW',
                title: 'Continue your learning',
                action: 'ALL COURSES',
                onAction: () => onSectionSelected(1),
              ),
              const SizedBox(height: 14),
              _ContinueCard(compact: compact, onPlay: () => onPlay(videos[0])),
              const SizedBox(height: 36),
              _SectionHeading(
                eyebrow: 'FRESH FROM THE CLASSROOM',
                title: 'Quick video lessons',
                action: 'VIDEO LIBRARY',
                onAction: () => onSectionSelected(3),
              ),
              const SizedBox(height: 14),
              _VideoRow(onPlay: onPlay, compact: compact),
              const SizedBox(height: 36),
              _SectionHeading(
                eyebrow: 'PICK YOUR NEXT CHALLENGE',
                title: 'Explore courses',
                action: 'BROWSE CATALOG',
                onAction: () => onSectionSelected(2),
              ),
              const SizedBox(height: 14),
              _CourseGrid(
                courseList: courses.take(3).toList(),
                compact: compact,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 20 : 28),
      decoration: BoxDecoration(
        color: yellow,
        border: Border.all(color: ink, width: 2),
        boxShadow: const [BoxShadow(color: ink, offset: Offset(6, 6))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SmallLabel('YOUR NEXT BIG IDEA STARTS HERE'),
                const SizedBox(height: 12),
                Text(
                  'Continue your\nUltimate Biology Course',
                  style: TextStyle(
                    fontSize: compact ? 29 : 42,
                    height: 1.04,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'You’re doing great, Sam. Let’s keep that streak alive.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 20),
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: paper,
                border: Border.all(color: ink, width: 2),
                borderRadius: BorderRadius.circular(56),
              ),
              child: const Icon(Icons.auto_awesome, size: 58),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(value: '08', label: 'HOURS LEARNED'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(value: '12', label: 'LESSONS DONE'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(value: '04', label: 'DAY STREAK'),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ink, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.action,
    required this.onAction,
  });

  final String eyebrow;
  final String title;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SmallLabel(eyebrow),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            foregroundColor: ink,
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
          child: Text(action),
        ),
      ],
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.compact, required this.onPlay});

  final bool compact;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ink, width: 2),
        boxShadow: const [BoxShadow(color: ink, offset: Offset(4, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: compact ? 4 : 3,
            child: _LessonArtwork(
              color: mint,
              icon: Icons.biotech,
              title: 'BIOLOGY\nFIELD NOTES',
              compact: compact,
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(compact ? 12 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Pill('LESSON 07 / 32', color: yellow),
                  const SizedBox(height: 8),
                  Text(
                    'How cells make energy',
                    style: TextStyle(
                      fontSize: compact ? 16 : 22,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mitochondria, ATP and the clever science of staying alive.',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  const _ProgressBar(progress: 0.38),
                  const SizedBox(height: 12),
                  _BlockButton(
                    label: 'WATCH LESSON',
                    icon: Icons.play_arrow,
                    onPressed: onPlay,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonArtwork extends StatelessWidget {
  const _LessonArtwork({
    required this.color,
    required this.icon,
    required this.title,
    this.compact = false,
  });

  final Color color;
  final IconData icon;
  final String title;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: compact ? 0.8 : 0.95,
      child: Container(
        color: color,
        child: Stack(
          children: [
            Positioned(
              right: -14,
              top: 8,
              child: Icon(icon, size: compact ? 76 : 112, color: ink),
            ),
            Positioned(
              left: 12,
              bottom: 13,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: compact ? 12 : 16,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label, {required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      color: color,
      child: Text(
        label,
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: paper,
            color: coral,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${(progress * 100).round()}% COMPLETE',
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}

class _BlockButton extends StatelessWidget {
  const _BlockButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: ink,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}

class _VideoRow extends StatelessWidget {
  const _VideoRow({required this.onPlay, required this.compact});

  final ValueChanged<VideoLesson> onPlay;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Column(
        children: videos
            .take(2)
            .map(
              (video) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _VideoCard(video: video, onTap: () => onPlay(video)),
              ),
            )
            .toList(),
      );
    }
    return Row(
      children: videos
          .map(
            (video) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _VideoCard(video: video, onTap: () => onPlay(video)),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.video, required this.onTap});

  final VideoLesson video;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ink, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 94,
              height: 78,
              color: video.color,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(video.icon, size: 42),
                  const Positioned(
                    right: 6,
                    bottom: 5,
                    child: Icon(Icons.play_circle_fill, size: 19),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SmallLabel(video.subject),
                    const SizedBox(height: 4),
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '▶  ${video.duration}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoursePage extends StatelessWidget {
  const _CoursePage({
    required this.title,
    required this.description,
    required this.searchQuery,
  });

  final String title;
  final String description;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final visibleCourses = courses
        .where(
          (course) =>
              course.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              course.subject.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              course.level.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageIntro(title: title, description: description),
          const SizedBox(height: 24),
          if (visibleCourses.isEmpty)
            const _EmptySearch()
          else
            _CourseGrid(courseList: visibleCourses, compact: false),
        ],
      ),
    );
  }
}

class _CourseGrid extends StatelessWidget {
  const _CourseGrid({required this.courseList, required this.compact});

  final List<Course> courseList;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = compact
            ? 1
            : constraints.maxWidth > 900
            ? 3
            : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: courseList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: compact ? 2.7 : 1.35,
          ),
          itemBuilder: (context, index) =>
              _CourseCard(course: courseList[index]),
        );
      },
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ink, width: 1.5),
        boxShadow: const [BoxShadow(color: ink, offset: Offset(3, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: course.color,
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Pill(course.level, color: Colors.white),
                  const Spacer(),
                  Icon(course.icon, size: 46),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${course.subject}  ·  ${course.lessons} video lessons',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ink, width: 2),
      ),
      child: const Text(
        'No courses found. Try a subject like Biology or Physics.',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _VideoLibraryPage extends StatelessWidget {
  const _VideoLibraryPage({required this.onPlay});

  final ValueChanged<VideoLesson> onPlay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PageIntro(
            title: 'Video library',
            description: 'Short, focused lessons for your next study session.',
          ),
          const SizedBox(height: 24),
          for (final video in videos)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _VideoCard(video: video, onTap: () => onPlay(video)),
            ),
        ],
      ),
    );
  }
}

class _InfoPage extends StatelessWidget {
  const _InfoPage({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: _PageIntro(title: title, description: description, icon: icon),
    );
  }
}

class _PageIntro extends StatelessWidget {
  const _PageIntro({
    required this.title,
    required this.description,
    this.icon = Icons.arrow_outward,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: yellow,
        border: Border.all(color: ink, width: 2),
        boxShadow: const [BoxShadow(color: ink, offset: Offset(5, 5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SmallLabel('CIPA INTERNATIONAL'),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(description),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, size: 38),
        ],
      ),
    );
  }
}

class VideoPreviewDialog extends StatelessWidget {
  const VideoPreviewDialog({required this.video, super.key});

  final VideoLesson video;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: paper,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: video.color,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(video.icon, size: 100),
                  const Icon(Icons.play_circle_fill, size: 68),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SmallLabel('${video.subject}  ·  ${video.duration}'),
                  const SizedBox(height: 7),
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This sample lesson is a preview. Add your own video player '
                    'and lesson content when you are ready.',
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE PREVIEW'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
