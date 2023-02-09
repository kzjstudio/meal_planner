import 'package:flutter/material.dart';
import 'package:meal_planner/main.dart';
import 'package:meal_planner/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filterScreen";

  final Function saveFilters;
  final Map<String, bool> currentFilter;
  const FiltersScreen(this.saveFilters, this.currentFilter, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten']!;
    _vegan = widget.currentFilter['vegan']!;
    _vegetarian = widget.currentFilter['vegetarian']!;
    _lactoseFree = widget.currentFilter['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subtitle,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      value: currentValue,
      onChanged: (value) => updateValue(value),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    "gluten": _glutenFree,
                    "lactose": _lactoseFree,
                    "vegan": _vegan,
                    "vegetarian": _vegetarian,
                  };
                  widget.saveFilters!(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust you meal selection.",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    "Gluten-free", "Only gluten-free meals", _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegitarian", "Only vegitarian meals", _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile("Vegan", "Only Vegan meals", _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Lactous-free", "Only Lactous-free meals", _lactoseFree,
                    (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ]));
  }
}
