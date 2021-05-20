import 'package:flutter/material.dart';

import 'package:multi_tela/utils/app_routs.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget _createItem(IconData icon,String label, Function onTap){
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 87,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.bottomCenter,
            child: Text(
            "Vamos Cozinhar?",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Theme.of(context).accentColor,
            ),
              textAlign: TextAlign.center,
          ),
          ),
          SizedBox(height: 10),
          _createItem(
            Icons.restaurant,
            'Refeições',
              ()=> {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.Home),
              }
          ),
          _createItem(
            Icons.settings,
            'Configurações',
              ()=> {
                Navigator.of(context).pushReplacementNamed(AppRoutes.SETTINGS),
              }
          ),
        ],
      ),
    );
  }
}
