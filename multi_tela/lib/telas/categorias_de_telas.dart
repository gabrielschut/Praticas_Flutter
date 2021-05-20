import 'package:flutter/material.dart';
import 'package:multi_tela/components/category_iten.dart';
import 'package:multi_tela/data/dummy_data.dart';
import 'package:multi_tela/models/categoria.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return  GridView(
          padding: const EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 225,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisExtent: 100,
            mainAxisSpacing: 10
          ),
        children: DUMMY_CATEGORIES.map((cat){
          return CategoryItem(cat);
        }).toList(),
      );
  }
}
