import 'package:flutter/material.dart';

import 'package:multi_tela/models/categoria.dart';
import 'package:multi_tela/data/dummy_data.dart';
import 'package:multi_tela/components/meal_item.dart';
import 'package:multi_tela/models/Meal.dart';

class CategoriesMealsScrenn extends StatelessWidget {

  final List<Meal> meals;

  const CategoriesMealsScrenn(this.meals);

    @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    final categoryMeals = meals.where((meal){
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title
        ),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder:(ctx, index){
          return MealItem(categoryMeals[index]);
       }
      ),
    );
  }
}
