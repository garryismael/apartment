import 'package:flutter/material.dart';
import 'package:prestation/pages/apartment/apartment_page.dart';
import 'package:prestation/pages/location/location.dart';
import 'package:prestation/pages/user/user.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  final List<Widget> _widgetOptions = [
    const ApartmentPage(),
    const LocationUserPage(),
    const MePage()
  ];

  final List<Widget> _titles = [
    const Text('Apartment List'),
    const Text('Location'),
    const Text('User Connected')
  ];

  @override
  Widget build(BuildContext context) {
    return _home();
  }

  Widget _home() {
    return Scaffold(
      appBar: AppBar(
        title: _titles.elementAt(_currentIndex),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.location_pin),
            title: const Text("Location"),
            selectedColor: Colors.purple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
