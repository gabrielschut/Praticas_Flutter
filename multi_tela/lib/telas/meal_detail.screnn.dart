import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_tela/models/Meal.dart';

class MealDeatilScrenn extends StatelessWidget {
  final Function(Meal) onTogleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDeatilScrenn(this.onTogleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 330,
      height: 180,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[350]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(
                        color: Colors.black87,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal)? Icons.star : Icons.star_border_sharp),
        splashColor: Colors.black87,
        onPressed: (){
          onTogleFavorite(meal);
        }
      ),
    );
  }
}
