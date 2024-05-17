import 'package:flutter/material.dart';
import 'favorite_screen.dart';
import 'categories_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text("C"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: "Categorias",
              ),
              Tab(
                icon: Icon(Icons.star),
                text: "Favoritos",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoriteScreen(),

          ],
        ),
      ),
      length: 2,
    );
  }
}
