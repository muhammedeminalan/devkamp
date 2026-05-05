import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShellScaffold extends StatelessWidget {
  const MainShellScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: PrimaryColor.primary100,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: PrimaryColor.primary600);
              }
              return const IconThemeData(color: NeutralColor.neutral500);
            },
          ),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: PrimaryColor.primary600,
                  fontWeight: FontWeight.w700,
                );
              }
              return const TextStyle(
                color: NeutralColor.neutral500,
                fontWeight: FontWeight.w500,
              );
            },
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border),
              selectedIcon: Icon(Icons.bookmark),
              label: 'Kaydedilenler',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
