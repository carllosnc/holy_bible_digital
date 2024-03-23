import 'package:go_router/go_router.dart';
import '/imports/app.dart';

bool firstTime = sharedPrefs.prefs.getBool('welcome') ?? true;

String homePath = firstTime ? '/home' : '';

final router = GoRouter(
  routes: [
    if (firstTime)
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const WelcomePage();
        },
      ),
    GoRoute(
      path: firstTime ? '/home' : '/',
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
