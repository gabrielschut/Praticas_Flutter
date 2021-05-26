import 'package:flutter/material.dart';

import 'categorias_de_telas.dart';
import 'favorite_screnn.dart';
import 'package:multi_tela/components/main_drawer.dart';
import 'package:multi_tela/models/Meal.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> _favoriteMeals;

  const TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScrennIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': "Categorias",
        'screnn': CategoriesScreen(),
      },
      {
        'title': "Favoritos",
        'screnn': FavoriteScrenn(widget._favoriteMeals),
      },
    ];
  }

  _selectScrenn(int index) {
    setState(() {
      _selectedScrennIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            _screens[_selectedScrennIndex]['title']
        ),
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScrennIndex]['screnn'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScrenn,
        unselectedItemColor: Color.fromRGBO(255, 254, 229, 1),
        selectedItemColor: Theme
            .of(context)
            .accentColor,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        currentIndex: _selectedScrennIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            //title: Text('Categorias'),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            //title: Text('Categorias'),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
