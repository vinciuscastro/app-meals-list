import 'package:flutter/material.dart';
import 'favorite_screen.dart';
import 'categories_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    _screens = [
      {
        "title": "Lista de Categorias",
        "screen": CategoriesScreen(),
      },
      {
        "title": "Meus Favoritos",
        "screen": FavoriteScreen(widget.favoriteMeals),
      },
    ];
    super.initState();
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_screens[_selectedScreenIndex]["title"] as String),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed("/settings");
              },
            )
          ],
        ),

        body: _screens[_selectedScreenIndex]["screen"] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).hintColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Categorias",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favoritos",
            ),
          ],

        )
      ),
    );
  }
}
