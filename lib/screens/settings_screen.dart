import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChanged;
  final Function toggleTheme;
  final Settings settings;

  const SettingsScreen(this.onSettingsChanged, this.settings, this.toggleTheme, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChange,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      value: value,
      onChanged: (value) {
        onChange(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Configurações",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  "Sem Glúten",
                  "Só exibe refeições sem glúten!",
                  settings.isGlutenFree,
                  (value) => setState(() => settings.isGlutenFree = value),
                ),
                _createSwitch(
                  "Sem Lactose",
                  "Só exibe refeições sem lactose!",
                  settings.isLactoseFree,
                  (value) => setState(() => settings.isLactoseFree = value),
                ),
                _createSwitch(
                  "Vegana",
                  "Só exibe refeições veganas!",
                  settings.isVegan,
                  (value) => setState(() => settings.isVegan = value),
                ),
                _createSwitch(
                  "Vegetariana",
                  "Só exibe refeições vegetarianas!",
                  settings.isVegetarian,
                  (value) => setState(() => settings.isVegetarian = value),
                ),
                SwitchListTile(
                  title: const Text("Modo Escuro"),
                  value: settings.isDarkMode,
                  onChanged: (value) {
                    widget.toggleTheme();
                    setState(() => settings.isDarkMode = value);
                  },
                ),
              ],
            ),
          ),
        ],
    ),
    );
  }
}
