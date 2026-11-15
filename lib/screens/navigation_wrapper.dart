import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'dart:ui';
import '../core/theme.dart';

import 'camera/main_camera_screen.dart';
import 'collection/research_collection_screen.dart';
import 'map/geographic_archive_map_screen.dart';
import '../services/auth_service.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MainCameraScreen(),
    const ResearchCollectionScreen(),
    const GeographicArchiveMapScreen(),
    const Scaffold(body: Center(child: Text('History'))),
    const _SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Key for blurred nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: IRecognizeTheme.background.withOpacity(0.8),
              border: Border(top: BorderSide(color: IRecognizeTheme.outlineVariant.withOpacity(0.15))),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F31332C),
                  blurRadius: 40,
                  offset: Offset(0, -12),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: IRecognizeTheme.onSecondaryContainer,
              unselectedItemColor: IRecognizeTheme.primary.withOpacity(0.7),
              selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.5, fontFamily: 'Manrope'),
              unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 1.5, fontFamily: 'Manrope'),
              showUnselectedLabels: true,
              items: [
                _buildNavItem(Symbols.photo_camera, 'CAMERA', 0),
                _buildNavItem(Symbols.library_books, 'COLLECTION', 1),
                _buildNavItem(Symbols.map, 'MAP', 2),
                _buildNavItem(Symbols.history, 'HISTORY', 3),
                _buildNavItem(Symbols.settings, 'SETTINGS', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? IRecognizeTheme.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          fill: isSelected ? 1 : 0,
        ),
      ),
      label: label,
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          Text('Your field archive', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: IRecognizeTheme.primary)),
          const SizedBox(height: 8),
          Text(AuthService().currentUser?.email ?? '', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: IRecognizeTheme.outline)),
          const SizedBox(height: 24),
          ListTile(leading: const Icon(Symbols.logout), title: const Text('Sign out'), onTap: () => AuthService().signOut()),
        ]),
      );
}
