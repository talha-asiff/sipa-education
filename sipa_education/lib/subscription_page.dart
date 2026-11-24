import 'package:flutter/material.dart';

import 'app_shell.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Subscription',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        children: [
          Text(
            'More ways to learn',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Subscription options are coming soon. You can explore and register for courses in the meantime.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF780147), Color(0xFF9B286A)],
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.workspace_premium_outlined,
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(height: 18),
                Text(
                  'SIPA Plus',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A richer learning experience is on the way.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 22),
                const _SubscriptionFeature(
                  icon: Icons.menu_book_outlined,
                  label: 'Curated learning resources',
                ),
                const _SubscriptionFeature(
                  icon: Icons.insights_outlined,
                  label: 'Learning progress tools',
                ),
                const _SubscriptionFeature(
                  icon: Icons.support_agent_outlined,
                  label: 'Dedicated learner support',
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70),
                  ),
                  child: const Text('Coming soon'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFECE4E9)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFF780147),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Start learning today with the courses already available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/courses'),
                  child: const Text('View courses'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionFeature extends StatelessWidget {
  const _SubscriptionFeature({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
