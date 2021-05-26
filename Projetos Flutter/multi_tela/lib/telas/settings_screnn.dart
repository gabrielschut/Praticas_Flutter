import 'package:flutter/material.dart';

import 'package:multi_tela/components/main_drawer.dart';
import 'package:multi_tela/models/settings.dart';

class SettingsScrenn extends StatefulWidget {
  final Function(Settings) onSettingsChanged;
  final Settings settings;

  const SettingsScrenn(this.settings, this.onSettingsChanged);

  @override
  _SettingsScrennState createState() => _SettingsScrennState();
}

class _SettingsScrennState extends State<SettingsScrenn> {
  Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtTitle,
    bool value,
    Function(bool) onChange,
  ) {
    return SwitchListTile.adaptive(
        title: Text(title),
        subtitle: Text(subtTitle),
        value: value,
        onChanged: (value) {
          onChange(value);
          widget.onSettingsChanged(settings);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Configurações',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _createSwitch(
                  'Sem glutem',
                  'Só exibe refeições sem glutem',
                  settings.isGlutenFree,
                  (value) => setState(() => settings.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem lactose',
                  'Só exibe refeições sem lactose',
                  settings.isLactoseFree,
                  (value) => setState(() => settings.isLactoseFree = value),
                ),
                _createSwitch(
                  'Vegano',
                  'Só exibe refeições Veganas',
                  settings.isVegan,
                  (value) => setState(() => settings.isVegan = value),
                ),
                _createSwitch(
                  'Vegetariano',
                  'Só exibe refeições vegatarianas',
                  settings.isVegetarian,
                  (value) => setState(() => settings.isVegetarian = value),
                ),
              ],
            )),
          ],
        ));
  }
}
