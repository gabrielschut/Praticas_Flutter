import 'package:flutter/material.dart';
import 'package:multi_tela/components/meal_item.dart';
import 'package:multi_tela/models/Meal.dart';

class FavoriteScrenn extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  const FavoriteScrenn(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(_favoriteMeals.isEmpty){
      return Center(
        child: Text('Nada salvo como favorito!'),
      );
    }else{
      return ListView.builder(
        itemCount: _favoriteMeals.length,
        itemBuilder: (ctx, index){
          return MealItem(_favoriteMeals[index]);
        },
      );
    }



  }
}
