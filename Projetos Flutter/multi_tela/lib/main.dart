import 'package:flutter/material.dart';
import 'package:multi_tela/telas/meal_detail.screnn.dart';
import 'package:multi_tela/telas/tabs_screnn.dart';

import 'data/dummy_data.dart';
import 'models/Meal.dart';
import 'models/settings.dart';
import 'telas/Categories_meals_screnn.dart';
import 'telas/settings_screnn.dart';
import 'utils/app_routs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availbleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availbleMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal){
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primaryColor: Colors.pink[400],
        accentColor: Colors.amberAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light()
            .textTheme
            .copyWith(headline6: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
      ),
      routes: {
        AppRoutes.Home: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScrenn(_availbleMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDeatilScrenn(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScrenn(settings, _filterMeals),
      },
    );
  }
}
