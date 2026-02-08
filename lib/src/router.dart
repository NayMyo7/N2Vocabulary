import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/about/about_screen.dart';
import 'features/favourites/favourites_screen.dart';
import 'features/home/home_screen.dart';
import 'features/search/search_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/favourites',
        builder: (context, state) => const FavouritesScreen(),
      ),
      GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('N2 Vocabulary')),
        body: Center(child: Text(state.error.toString())),
      );
    },
  );
}
