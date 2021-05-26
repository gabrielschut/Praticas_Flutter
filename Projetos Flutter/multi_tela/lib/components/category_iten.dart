import 'package:flutter/material.dart';
import 'package:multi_tela/models/categoria.dart';
import 'package:multi_tela/utils/app_routs.dart';

class CategoryItem extends StatelessWidget {

  final Category category;

 CategoryItem(this.category);

 void _selectCategory(BuildContext context){
   Navigator.of(context).pushNamed(
     AppRoutes.CATEGORIES_MEALS,
     arguments: category,
   );
 }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => _selectCategory(context),
      splashColor: Colors.grey[600],
      child: Container(
        padding: EdgeInsets.only(
          left: 16 ,
          top: 25,
          right: 10,
          bottom: 15,
        ),
        child: Text(
            category.title,
          style: Theme.of(context).textTheme.headline6,
          ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
