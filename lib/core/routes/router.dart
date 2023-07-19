import 'package:flutter_starter/domain/domain.dart';
import 'package:go_router/go_router.dart';
import '/pages/pages.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: 'book',
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;

            final book = extras['book'] as int;
            final chapter = extras['chapter'] as int;

            return BookPage(
              chapter: chapter,
              book: book,
            );
          },
        ),
        GoRoute(
          path: 'verse',
          builder: (context, state) {
            final verse = state.extra as Verse;

            return VersePage(
              verse: verse,
            );
          },
        ),
      ],
    )
  ],
);
