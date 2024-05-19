import 'package:flutter/material.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';
import 'screens/tab_screen.dart';
import 'screens/settings_screen.dart';
import 'models/meal.dart';
import 'models/settings.dart';
import 'data/dummy_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeMode _themeMode = ThemeMode.system;
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  Settings settings = Settings();


  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _filterMeals(Settings settings){
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten && !filterLactose && !filterVegan && !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal){
    setState(() {
      if(_favoriteMeals.contains(meal)){
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal){
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        hintColor: Colors.cyan,
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 250, 220, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
          )
        )
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        hintColor: Colors.cyan,
          scaffoldBackgroundColor: Colors.grey[800],
        fontFamily: 'Raleway',

        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'RobotoCondensed',
            color: Colors.white,
            fontSize: 20,
          )
        )
      ),
      themeMode: _themeMode,
      home: TabsScreen(_favoriteMeals),
      routes: {
        // AppRoutes.HOME: (ctx) => CategoriesScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(_filterMeals, settings, _toggleTheme),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      },
    );
  }
}