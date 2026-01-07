import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/add_expense/add_expense_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/expenses_list/expenses_list_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/roadmap/roadmap_screen.dart';
import '../features/categories/categories_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) => _ScaffoldWithNav(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: '/add',
            name: 'add',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AddExpenseScreen(),
            ),
          ),
          GoRoute(
            path: '/expenses',
            name: 'expenses',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ExpensesListScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/settings/categories',
        name: 'categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/settings/roadmap',
        name: 'roadmap',
        builder: (context, state) => const RoadmapScreen(),
      ),
    ],
  );
});

class _ScaffoldWithNav extends StatefulWidget {
  const _ScaffoldWithNav({required this.child});

  final Widget child;

  @override
  State<_ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends State<_ScaffoldWithNav> {
  int _indexForLocation(String location) {
    if (location.startsWith('/add')) return 1;
    if (location.startsWith('/expenses')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/add');
        break;
      case 2:
        context.go('/expenses');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexForLocation(location);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => _onTap(context, value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Expenses'),
        ],
      ),
    );
  }
}
